import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_social_media/entities/conversation/conversation_entities.dart';
import 'package:recipe_social_media/entities/recipe/recipe_entities.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/navigation/args/recipe_interaction/recipe_interaction_page_arguments.dart';
import 'package:recipe_social_media/repositories/navigation/args/recipe_interaction/recipe_interaction_page_response_arguments.dart';
import 'package:recipe_social_media/repositories/navigation/navigation_repo.dart';
import 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

export 'conversation_bloc.dart';
part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  ConversationBloc(this._navigationRepo, this._authRepo, this._recipeRepo) : super(ConversationState(
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
  }

  final NavigationRepository _navigationRepo;
  final AuthenticationRepository _authRepo;
  final RecipeRepository _recipeRepo;

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

  void _attachImagesToMessage(AttachImages event, Emitter<ConversationState> emit) {
    for (var img in event.imageFiles) {
      print(img.path);
    }
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
        dialogMessage: result.dialogMessage
      ));
    }
  }

  Future<List<Recipe>> _getCurrentUserRecipesAndReturn() async {
    String? userId = (await _authRepo.currentUser).id;
    return await _recipeRepo.getRecipesFromUserId(userId);
  }

  void _getCurrentUserRecipes(GetCurrentUserRecipes event, Emitter<ConversationState> emit) async {
    if (!state.fetchRecipes) return;
    List<Recipe> currentRecipes = await _getCurrentUserRecipesAndReturn();

    emit(state.copyWith(
      fetchRecipes: false,
      currentRecipes: currentRecipes
    ));
  }

  void _initState(InitState event, Emitter<ConversationState> emit) async {
    final senderId = (await _authRepo.currentUser).id;
    emit(state.copyWith(messagesLoading: true, senderId: senderId));

    final messages = _getMessagesFromConversation();
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
      fetchRecipes: false,
      currentRecipes: currentRecipes,
      checkboxValues: List.generate(currentRecipes.length, (_) => false),
      messagesLoading: false
    ));
  }

  void _changeMessagesToDisplay(ChangeMessagesToDisplay event, Emitter<ConversationState> emit) async {
    emit(state.copyWith(dialogMessage: "", dialogTitle: ""));
    // TODO: get messages from API
  }

  List<Message> _getMessagesFromConversation() {
    return [
      Message("1", "2", "Sender 2", const [], DateTime(2024, 01, 21, 9, 0), null, null,
        "Hey how are you doing?", null, null
      ),
      Message("2", state.senderId, "Sender 1", const[], DateTime(2024, 01, 21, 11, 30), null, null,
        null,
        ["ag3pi6mfvqnzaknnmqri", "d3uwdc4ekb4z9dkgqc9f"], null
      )
    ];
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