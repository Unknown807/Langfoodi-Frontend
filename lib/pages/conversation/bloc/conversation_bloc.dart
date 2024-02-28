import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_social_media/api/api.dart';
import 'package:recipe_social_media/entities/conversation/conversation_entities.dart';
import 'package:recipe_social_media/entities/recipe/recipe_entities.dart';
import 'package:recipe_social_media/entities/user/user_entities.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/conversation/conversation_repo.dart';
import 'package:recipe_social_media/repositories/image/image_repo.dart';
import 'package:recipe_social_media/repositories/message/message_repo.dart';
import 'package:recipe_social_media/repositories/navigation/args/recipe_interaction/recipe_interaction_page_arguments.dart';
import 'package:recipe_social_media/repositories/navigation/args/recipe_interaction/recipe_interaction_page_response_arguments.dart';
import 'package:recipe_social_media/repositories/navigation/navigation_repo.dart';
import 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';
import 'package:recipe_social_media/utilities/utilities.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

export 'conversation_bloc.dart';
part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  ConversationBloc(
    this._navigationRepo,
    this._authRepo,
    this._recipeRepo,
    this._messageRepo,
    this._imageRepo,
    this._conversationRepo,
    this._networkManager,
    this._messagingHub) : super(ConversationState(
      messageTextController: TextEditingController(),
      messageListScrollController: GroupedItemScrollController()
    )) {
      on<InitState>(_initState);
      on<GoToInteractionPageAndExpectResult>(_goToInteractionPageAndExpectResult);
      on<AttachImages>(_attachImagesToMessage);
      on<SetCheckboxValue>(_setCheckboxValue);
      on<ScrollToMessage>(_scrollToMessage);
      on<SendMessage>(_sendMessage);
      on<DetachImage>(_detachImage);
      on<AttachRecipes>(_attachRecipes);
      on<ResetPopupDialog>(_resetPopupDialog);
      on<CancelRecipeAttachment>(_cancelRecipeAttachment);
      on<RemoveMessage>(_removeMessage);
      on<ReplyToMessage>(_replyToMessage);
      on<SearchMessages>(_searchMessages);
      on<ReceiveMessage>(_showReceivedMessage);
      on<ReceiveMessageDeletion>(_showReceivedMessageDeletion);
      on<ReceiveMessageMarkedAsRead>(_showReceivedMessageMarkedAsRead);

      _messagingHub.onMessageReceived((message, conversationId) async {
        if (conversationId != state.conversationId) {
          return;
        }
        if (state.messages.any((m) => m.id == message.id)) {
          return;
        }

        if (!isClosed) {
          add(ReceiveMessage(message));
        }
      });

      _messagingHub.onMessageDeleted((messageId) async {
        if (!state.messages.any((m) => m.id == messageId)) {
          return;
        }

        if (!isClosed) {
          add(ReceiveMessageDeletion(messageId));
        }
      });

      _messagingHub.onMessageMarkedAsRead((messageId, userId) async {
        if (!state.messages.any((m) => m.id == messageId)) {
          return;
        }

        if (!isClosed) {
          add(ReceiveMessageMarkedAsRead(messageId, userId));
        }
      });
  }

  final NavigationRepository _navigationRepo;
  final AuthenticationRepository _authRepo;
  final RecipeRepository _recipeRepo;
  final MessageRepository _messageRepo;
  final ImageRepository _imageRepo;
  final ConversationRepository _conversationRepo;
  final NetworkManager _networkManager;
  final MessagingHub _messagingHub;

  void _showReceivedMessage(ReceiveMessage event, Emitter<ConversationState> emit) {
    List<Message> newMessages = List.from(state.messages);
    newMessages.add(event.message);

    emit(state.copyWith(
      messages: newMessages,
    ));
  }

  void _showReceivedMessageDeletion(ReceiveMessageDeletion event, Emitter<ConversationState> emit) {
    List<Message> messages = List.from(state.messages);
    messages.removeWhere((msg) => msg.id == event.messageId);

    emit(state.copyWith(
      messages: messages,
      repliedMessageIsSentByMe: false,
      repliedMessage: const Message("", UserPreviewForMessage("", "", null), [], null, null, "", "", null, null),
    ));
  }

  void _showReceivedMessageMarkedAsRead(ReceiveMessageMarkedAsRead event, Emitter<ConversationState> emit) {
    List<Message> messages = List.from(state.messages);
    messages.firstWhere((m) => m.id == event.messageId)
        .seenByUserIds
        .add(event.userId);

    emit(state.copyWith(
      pageLoading: true
    ));

    emit(state.copyWith(
        messages: messages,
        pageLoading: false
    ));
  }

  void _replyToMessage(ReplyToMessage event, Emitter<ConversationState> emit) async {
    emit(state.copyWith(
      repliedMessage: event.message ?? const Message("", UserPreviewForMessage("", "", null), [], null, null, "", "", null, null),
      repliedMessageIsSentByMe: state.senderId == event.message?.userPreview.id
    ));
  }

  void _removeMessage(RemoveMessage event, Emitter<ConversationState> emit) async {
    if (!await _networkManager.isNetworkConnected()) {
      return emit(state.copyWith(
        dialogTitle: "Oops!",
        dialogMessage: "Network issue encountered, please check your internet connection"
      ));
    }

    bool success = await _messageRepo.removeMessage(event.id);

    if (!success) {
      emit(state.copyWith(
        dialogTitle: "Oops!",
        dialogMessage: "Could not delete message, please check and try again."
      ));
    }
  }

  void _resetPopupDialog(ResetPopupDialog event, Emitter<ConversationState> emit) {
    emit(state.copyWith(
      dialogTitle: "",
      dialogMessage: "",
    ));
  }

  Future<List<HostedImage>?> attemptImageHosting(List<String> imagePaths) async {
    List<HostedImage> hostedImages = [];
    Signature? uploadSignature = await _imageRepo.getSignature();
    if (uploadSignature == null) return null;

    bool uploadSuccess = true;
    final uploadContract = SignedUploadContract(uploadSignature.signature, uploadSignature.timeStamp);
    for (String imagePath in imagePaths) {
      HostedImage? hostedImage = await _imageRepo.uploadImage(imagePath, uploadContract);
      if (hostedImage == null) {
        uploadSuccess = false;
        break;
      }

      hostedImages.add(hostedImage);
    }

    if (!uploadSuccess) {
      await _imageRepo.removeImages(hostedImages.map((i) => i.publicId).toList());
      return null;
    }

    return hostedImages;
  }

  void _sendMessage(SendMessage event, Emitter<ConversationState> emit) async {
    if (!await _networkManager.isNetworkConnected()) {
      return emit(state.copyWith(
        dialogTitle: "Oops!",
        dialogMessage: "Network issue encountered, please check your internet connection"
      ));
    }

    String textContent = state.messageTextController.text;
    List<Recipe> attachedRecipes = List.from(state.attachedRecipes);
    List<String> attachedImagePaths = List.from(state.attachedImagePaths);

    if (state.pageLoading
      || state.sendingMessage
      || textContent.isEmpty
      && (attachedRecipes.isEmpty && attachedImagePaths.isEmpty)) return;

    String? messageRepliedToId = state.repliedMessage.id.isNotEmpty
      ? state.repliedMessage.id
      : null;

    emit(state.copyWith(
      sendingMessage: true,
      allowImages: true,
      allowRecipes: true,
      repliedMessageIsSentByMe: false,
      attachedImagePaths: [],
      attachedRecipes: [],
      repliedMessage: const Message("", UserPreviewForMessage("", "", null), [], null, null, "", "", null, null),
      checkboxValues: List.generate(state.currentRecipes.length, (_) => false),
    ));
    state.messageTextController.clear();

    List<HostedImage>? hostedImages;
    if (attachedImagePaths.isNotEmpty) {
      hostedImages = await attemptImageHosting(attachedImagePaths);
      if (hostedImages == null) {
        return emit(state.copyWith(
          sendingMessage: false,
          dialogTitle: "Oops!",
          dialogMessage: "There was an issue while trying to send your images, please check and try again.",
        ));
      }
    }

    SendMessageContract contract = SendMessageContract(
      conversationId: state.conversationId,
      senderId: state.senderId,
      messageRepliedToId: messageRepliedToId,
      text: textContent.isNotEmpty ? textContent : null,
      imageURLs: hostedImages?.map((i) => i.publicId).toList(),
      recipeIds: attachedRecipes.isNotEmpty
        ? attachedRecipes.map((r) => r.id).toList()
        : null,
    );
    Message? sentMessage = await _messageRepo.sendMessage(contract);

    if (sentMessage == null) {
      if (hostedImages != null) {
        await _imageRepo.removeImages(hostedImages.map((i) => i.publicId).toList());
      }

      emit(state.copyWith(
        sendingMessage: false,
        dialogTitle: "Oops!",
        dialogMessage: "There was an issue sending your message, please check and try again.",
      ));
    }
    else {
      emit(state.copyWith(
        sendingMessage: false,
      ));
    }
  }

  void _detachImage(DetachImage event, Emitter<ConversationState> emit) {
    List<String> attachedImagePaths = List.from(state.attachedImagePaths);
    attachedImagePaths.removeAt(event.index);

    emit(state.copyWith(
      attachedImagePaths: attachedImagePaths,
      allowRecipes: attachedImagePaths.isEmpty
    ));
  }

  void _searchMessages(SearchMessages event, Emitter<ConversationState> emit) async {
    final searchTerm = event.searchTerm.toLowerCase();
    if (searchTerm.isEmpty) return;

    int scrollIndex = -1;
    final length = state.messages.length;
    for (int i=0; i<length; i++) {
      final text = state.messages[i].textContent;
      if (text != null && text.toLowerCase().contains(searchTerm)) {
        scrollIndex = length - i - 2;
        break;
      }
    }
    if (scrollIndex < 0) return;

    state.messageListScrollController.scrollTo(
      duration: const Duration(milliseconds: 200),
      index: scrollIndex,
    );
  }


  void _scrollToMessage(ScrollToMessage event, Emitter<ConversationState> _) {
    int index = (state.messages.length - state.messages.indexWhere((msg) => msg.id == event.id)) - 2;
    if (index < 0) index = 0;

    state.messageListScrollController.scrollTo(
      duration: const Duration(milliseconds: 200),
      index: index,
    );
  }

  void _setCheckboxValue(SetCheckboxValue event, Emitter<ConversationState> emit) {
    List<bool> newCheckboxValues = List.from(state.checkboxValues);
    newCheckboxValues[event.index] = event.value;

    emit(state.copyWith(
      checkboxValues: newCheckboxValues
    ));
  }

  void _attachRecipes(AttachRecipes event, Emitter<ConversationState> emit) {
    List<Recipe> attachedRecipes = [];
    for (int i = 0; i < state.currentRecipes.length; i++) {
      if (state.checkboxValues[i]) {
        attachedRecipes.add(state.currentRecipes[i]);
      }
    }

    emit(state.copyWith(
      attachedRecipes: attachedRecipes,
      allowImages: attachedRecipes.isEmpty
    ));
  }

  void _cancelRecipeAttachment(CancelRecipeAttachment event, Emitter<ConversationState> emit) {
    List<bool> checkboxValues = List.generate(state.checkboxValues.length, (_) => false);
    for (int i = 0; i < state.currentRecipes.length; i++) {
      if (state.attachedRecipes.contains(state.currentRecipes[i])) {
        checkboxValues[i] = true;
      }
    }

    emit(state.copyWith(
      checkboxValues: checkboxValues
    ));
  }

  void _attachImagesToMessage(AttachImages event, Emitter<ConversationState> emit) {
    List<String> imagePaths = List.from(state.attachedImagePaths);
    for (var img in event.imageFiles) {
      if (!imagePaths.contains(img.path)) {
        imagePaths.add(img.path);
      }
    }

    emit(state.copyWith(
      attachedImagePaths: imagePaths,
      allowRecipes: imagePaths.isEmpty
    ));
  }

  void _goToInteractionPageAndExpectResult(GoToInteractionPageAndExpectResult event, Emitter<ConversationState> emit) async {
    BuildContext eventContext = event.context;
    RecipeInteractionPageResponseArguments? result = await _navigationRepo.goTo(
      eventContext,
      "/recipe-interaction",
      routeType: RouteType.expect,
      arguments: event.arguments) as RecipeInteractionPageResponseArguments?;

    if (result != null) {
      emit(state.copyWith(pageLoading: true));
      List<Recipe> currentRecipes = await _getCurrentUserRecipesAndReturn();

      emit(state.copyWith(
        pageLoading: false,
        allowImages: true,
        allowRecipes: true,
        dialogTitle: result.dialogTitle,
        dialogMessage: result.dialogMessage,
        currentRecipes: currentRecipes,
        attachedRecipes: [],
        checkboxValues: List.generate(currentRecipes.length, (_) => false),
      ));
    }
  }

  Future<List<Recipe>> _getCurrentUserRecipesAndReturn() async {
    if (!await _networkManager.isNetworkConnected()) return [];

    String? userId = (await _authRepo.currentUser).id;
    return await _recipeRepo.getRecipesFromUserId(userId);
  }

  void _initState(InitState event, Emitter<ConversationState> emit) async {
    if (!await _networkManager.isNetworkConnected()) {
      return emit(state.copyWith(
        dialogTitle: "Oops!",
        dialogMessage: "Network issue encountered, please check your internet connection"
      ));
    }

    emit(state.copyWith(isBlocked: event.isBlocked));

    final senderId = (await _authRepo.currentUser).id;
    emit(state.copyWith(pageLoading: true, senderId: senderId));

    List<Message> messages = await _messageRepo.getMessagesFromConversation(event.conversation.id);
    final nameColours = _generateNameColours(event.conversation.userIds);
    List<Recipe> currentRecipes = await _getCurrentUserRecipesAndReturn();

    await _conversationRepo.markConversationAsRead(event.conversation.id, senderId);
    messages.forEach(((msg) => msg.seenByUserIds.add(senderId)));

    emit(state.copyWith(
      conversationId: event.conversation.id,
      conversationName: event.conversation.name,
      isGroup: event.conversation.isGroup,
      userIds: event.conversation.userIds,
      messages: messages,
      nameColours: nameColours,
      currentRecipes: currentRecipes,
      checkboxValues: List.generate(currentRecipes.length, (_) => false),
      pageLoading: false
    ));
  }

  Map<String, Color> _generateNameColours(List<String> userIds) {
    Map<String, Color> nameColours = {};
    for (String id in userIds) {
      nameColours.putIfAbsent(
        id, () {
          final colorHex = (Random().nextDouble() * 0xFFFFFFFF).toString();
          return Color(int.parse(colorHex.substring(0, 6), radix: 16) + 0xFF000000);
        }
      );
    }

    return nameColours;
  }
}