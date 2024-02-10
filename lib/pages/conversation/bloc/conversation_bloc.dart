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
    final messages = _getMessagesFromConversation();
    // TODO: get senderId from currentUser in auth repo
    final nameColours = _generateNameColours(messages);

    List<Recipe> currentRecipes = await _getCurrentUserRecipesAndReturn();

    emit(state.copyWith(
      conversationName: event.conversationName,
      conversationStatus: event.conversationStatus,
      isGroup: event.isGroup,
      messages: messages,
      nameColours: nameColours,
      senderId: "1",
      fetchRecipes: false,
      currentRecipes: currentRecipes,
      checkboxValues: List.generate(currentRecipes.length, (_) => false)
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
      Message("2", "1", "Sender 1", const[], DateTime(2024, 01, 21, 11, 30), null, null,
        null,
        ["ag3pi6mfvqnzaknnmqri", "d3uwdc4ekb4z9dkgqc9f"], null
      )
    ];
    //   Message(id: "3", senderId: "2", senderName: "Sender 2",
    //     textContent: "here's a pic of me :)",
    //     sentDate: DateTime(2024, 02, 21, 12, 15),
    //     imageURLs: ["q8jjeukocprdiblv25tf"]
    //   ),
    //   Message(id: "4", senderId: "1", senderName: "Sender 1",
    //     textContent: "You seen my recipes, check 'em out! They're pretty neat my guy. Anyways...lemme see your recipes",
    //     sentDate: DateTime(2024, 10, 25, 12, 20),
    //     recipePreviews: const [
    //       RecipePreview("6586f5660423a34d151f4424", "Long ass recipe name ain't this a cool name no?", null),
    //       RecipePreview("658447bb717f5f37d4f32104", "recipe2",  "ag3pi6mfvqnzaknnmqri")
    //     ],
    //   ),
    //   Message(id: "5", senderId: "2", senderName: "Sender 2",
    //     textContent: "Nice, its similar to what I made yesterday -",
    //     sentDate: DateTime(2024, 10, 25, 13, 45),
    //     recipePreviews: const [
    //       RecipePreview("65885d44cf28ab4f72179f11", "recipe3", "d3uwdc4ekb4z9dkgqc9f")
    //     ]
    //   ),
    //   Message(id: "6", senderId: "2", senderName: "Sender 2",
    //     repliedToMessageId: "5",
    //     textContent: "Seeya later!",
    //     sentDate: DateTime(2024, 10, 25, 14, 55),
    //   ),
    //   Message(id: "7", senderId: "1", senderName: "Sender 2",
    //     repliedToMessageId: "5",
    //     textContent: "Seeya later!",
    //     sentDate: DateTime(2024, 10, 25, 14, 55),
    //   ),
    //   Message(id: "8", senderId: "2", senderName: "Sender 2",
    //     repliedToMessageId: "5",
    //     textContent: "Seeya later!",
    //     sentDate: DateTime(2024, 10, 25, 14, 55),
    //   ),
    //   Message(id: "9", senderId: "1", senderName: "Sender 1",
    //     repliedToMessageId: "3",
    //     textContent: "Seeya later!",
    //     sentDate: DateTime(2024, 10, 25, 14, 55),
    //   ),
    //   Message(id: "10", senderId: "2", senderName: "Sender 2",
    //     repliedToMessageId: "4",
    //     textContent: "Seeya later!",
    //     sentDate: DateTime(2024, 10, 25, 14, 55),
    //   ),
    //   Message(id: "11", senderId: "1", senderName: "Sender 1",
    //     repliedToMessageId: "5",
    //     textContent: "Seeya later!",
    //     sentDate: DateTime(2024, 10, 25, 14, 55),
    //   ),
    //   Message(id: "12", senderId: "2", senderName: "Sender 2",
    //     repliedToMessageId: "2",
    //     textContent: "Seeya later! and make sure to call me when you're done!",
    //     sentDate: DateTime(2024, 10, 25, 14, 55),
    //   ),
    //   Message(id: "13", senderId: "1", senderName: "Sender 1",
    //     repliedToMessageId: "12",
    //     textContent: "Seeya later!",
    //     sentDate: DateTime(2024, 10, 25, 14, 55),
    //   ),
    // ];
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