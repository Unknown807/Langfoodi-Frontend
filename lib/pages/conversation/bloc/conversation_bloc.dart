import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_social_media/entities/conversation/conversation_entities.dart';
import 'package:recipe_social_media/entities/recipe/recipe_entities.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
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
    this._networkManager) : super(ConversationState(
      messageTextController: TextEditingController(),
      messageListScrollController: GroupedItemScrollController()
    )) {
      on<InitState>(_initState);
      on<ChangeMessagesToDisplay>(_changeMessagesToDisplay);
      on<GoToInteractionPageAndExpectResult>(_goToInteractionPageAndExpectResult);
      on<AttachImages>(_attachImagesToMessage);
      on<GetCurrentUserRecipes>(_getCurrentUserRecipes);
      on<SetCheckboxValue>(_setCheckboxValue);
      on<ScrollToMessage>(_scrollToMessage);
      on<SendMessage>(_sendMessage);
      on<DetachImage>(_detachImage);
      on<AttachRecipes>(_attachRecipes);
   }

  final NavigationRepository _navigationRepo;
  final AuthenticationRepository _authRepo;
  final RecipeRepository _recipeRepo;
  final MessageRepository _messageRepo;
  final ImageRepository _imageRepo;
  final NetworkManager _networkManager;

  Future<List<HostedImage>?> attemptImageHosting() async {
    List<HostedImage> hostedImages = [];
    Signature? uploadSignature = await _imageRepo.getSignature();
    if (uploadSignature == null) return null;

    bool uploadSuccess = true;
    final uploadContract = SignedUploadContract(uploadSignature.signature, uploadSignature.timeStamp);
    for (String imagePath in state.attachedImagePaths) {
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
    bool hasNetwork = await _networkManager.isNetworkConnected();
    if (!hasNetwork) {
      return emit(state.copyWith(
        dialogTitle: "Oops!",
        dialogMessage: "Network issue encountered, please check your internet connection"
      ));
    }

    String textContent = state.messageTextController.text;
    if (state.pageLoading
      || textContent.isEmpty
      && (state.attachedRecipes.isEmpty && state.attachedImagePaths.isEmpty)) return;

    emit(state.copyWith(sendingMessage: true));
    state.messageTextController.clear();

    List<HostedImage>? hostedImages;
    if (state.attachedImagePaths.isNotEmpty) {
      hostedImages = await attemptImageHosting();
      if (hostedImages == null) {
        return emit(state.copyWith(
          sendingMessage: false,
          dialogTitle: "Oops!",
          dialogMessage: "There was an issue while trying to send your images, please check and try again.",
        ));
      }
    }

    NewMessageContract contract = NewMessageContract(
      conversationId: state.conversationId,
      senderId: state.senderId,
      text: textContent.isNotEmpty ? textContent : null,
      imageURLs: hostedImages?.map((i) => i.publicId).toList(),
      recipeIds: state.attachedRecipes.isNotEmpty
        ? state.attachedRecipes.map((r) => r.id).toList()
        : null,
      //TODO: replied message Id to be added here
    );
    Message? sentMessage = await _messageRepo.sendMessage(contract);

    if (sentMessage != null) {
      List<Message> newMessages = List.from(state.messages);
      newMessages.add(sentMessage);

      emit(state.copyWith(
        sendingMessage: false,
        messages: newMessages,
        allowImages: true,
        allowRecipes: true,
        attachedRecipes: [],
        attachedImagePaths: [],
        checkboxValues: List.generate(state.currentRecipes.length, (_) => false)
      ));
    } else {
      if (hostedImages != null) {
        await _imageRepo.removeImages(hostedImages.map((i) => i.publicId).toList());
      }

      emit(state.copyWith(
        sendingMessage: false,
        dialogTitle: "Oops!",
        dialogMessage: "There was an issue sending your message, please check and try again.",
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

  void _scrollToMessage(ScrollToMessage event, Emitter<ConversationState> _) {
    int index = (state.messages.length - state.messages.indexWhere((msg) => msg.id == event.id)) - 2;
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
      emit(state.copyWith(
        dialogTitle: result.dialogTitle,
        dialogMessage: result.dialogMessage,
      ));
    }
  }

  Future<List<Recipe>> _getCurrentUserRecipesAndReturn() async {
    String? userId = (await _authRepo.currentUser).id;
    return await _recipeRepo.getRecipesFromUserId(userId);
  }

  void _getCurrentUserRecipes(GetCurrentUserRecipes event, Emitter<ConversationState> emit) async {
    emit(state.copyWith(dialogTitle: "", dialogMessage: ""));
    bool hasNetwork = await _networkManager.isNetworkConnected();
    if (!hasNetwork) return;

    emit(state.copyWith(pageLoading: true));
    List<Recipe> currentRecipes = await _getCurrentUserRecipesAndReturn();
    emit(state.copyWith(currentRecipes: currentRecipes, pageLoading: false));
  }

  void _initState(InitState event, Emitter<ConversationState> emit) async {
    final senderId = (await _authRepo.currentUser).id;
    emit(state.copyWith(pageLoading: true, senderId: senderId));

    List<Message> messages = await _getMessagesFromConversationAndReturn(event.conversation.id);
    final nameColours = _generateNameColours(messages);
    List<Recipe> currentRecipes = await _getCurrentUserRecipesAndReturn();

    emit(state.copyWith(
      //TODO: status will be refactored eventually
      //conversationStatus: event.conversationStatus,
      conversationId: event.conversation.id,
      conversationName: event.conversation.name,
      isGroup: event.conversation.isGroup,
      messages: messages,
      nameColours: nameColours,
      currentRecipes: currentRecipes,
      checkboxValues: List.generate(currentRecipes.length, (_) => false),
      pageLoading: false
    ));
  }

  void _changeMessagesToDisplay(ChangeMessagesToDisplay event, Emitter<ConversationState> emit) async {
    emit(state.copyWith(dialogMessage: "", dialogTitle: "", pageLoading: true));
    List<Message> messages = await _getMessagesFromConversationAndReturn(state.conversationId);
    final nameColours = _generateNameColours(messages);

    emit(state.copyWith(
      pageLoading: false,
      messages: messages,
      nameColours: nameColours
    ));
  }

  Future<List<Message>> _getMessagesFromConversationAndReturn(String conversationId) async {
    return await _messageRepo.getMessagesFromConversation(conversationId);
  }

  Map<String, Color> _generateNameColours(List<Message> messages) {
    Map<String, Color> nameColours = {};
    for (var msg in messages) {
      nameColours.putIfAbsent(
        msg.senderId,
        () {
          final colorHex = (Random().nextDouble() * 0xFFFFFFFF).toString();
          return Color(int.parse(colorHex.substring(0, 6), radix: 16) + 0xFF000000);
        }
      );
    }

    return nameColours;
  }
}