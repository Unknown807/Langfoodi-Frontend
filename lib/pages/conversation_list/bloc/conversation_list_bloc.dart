import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:recipe_social_media/api/api.dart';
import 'package:recipe_social_media/entities/conversation/conversation_entities.dart';
import 'package:recipe_social_media/entities/user/user_entities.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/conversation/conversation_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:recipe_social_media/repositories/navigation/navigation_repo.dart';
import 'package:recipe_social_media/utilities/utilities.dart';

export 'conversation_list_bloc.dart';
part 'conversation_list_event.dart';
part 'conversation_list_state.dart';

class ConversationListBloc extends Bloc<ConversationListEvent, ConversationListState> {
  ConversationListBloc(
    this._conversationRepo,
    this._authRepo,
    this._networkManager,
    this._navigationRepo,
    this._messagingHub)
    : super(const ConversationListState()) {
    on<ChangeConversationsToDisplay>(_changeConversationsToDisplay);
    on<SearchConversations>(_searchConversations);
    on<PinConversation>(_pinConversation);
    on<UnpinConversation>(_unpinConversation);
    on<LeaveGroup>(_leaveGroup);
    on<ResetPopupDialog>(_resetPopupDialog);
    on<ReceiveMessage>(_showReceivedMessage);
    on<GoToAddConnectionPageAndExpectResult>(_goToAddConnectionPageAndExpectResult);
    on<GoToAddGroupPageAndExpectResult>(_goToAddGroupPageAndExpectResult);

    _messagingHub.onMessageReceived((message, conversationId) {
      if (!state.conversations.any((convo) => convo.id == conversationId)) {
        return;
      }

      add(ReceiveMessage(message, conversationId));
    });
  }

  final AuthenticationRepository _authRepo;
  final ConversationRepository _conversationRepo;
  final NetworkManager _networkManager;
  final NavigationRepository _navigationRepo;
  final MessagingHub _messagingHub;

  void _goToAddConnectionPageAndExpectResult(GoToAddConnectionPageAndExpectResult event, Emitter<ConversationListState> emit) async {
    await _goToPageAndExpectResult("/add-connection", event.context, emit);
  }

  void _goToAddGroupPageAndExpectResult(GoToAddGroupPageAndExpectResult event, Emitter<ConversationListState> emit) async {
    await _goToPageAndExpectResult("/add-group", event.context, emit);
  }

  Future _goToPageAndExpectResult(String routeName, BuildContext context, Emitter<ConversationListState> emit) async {
    BuildContext eventContext = context;
    await _navigationRepo.goTo(
        eventContext,
        routeName,
        routeType: RouteType.expect
    );

    await _changeConversations(emit);
    await _sortConversations(emit);
  }

  void _showReceivedMessage(ReceiveMessage event, Emitter<ConversationListState> emit) async {
    List<Conversation> conversations = List.from(state.conversations);
    var conversation = conversations.firstWhere((convo) => convo.id == event.conversationId);

    conversation.lastMessage = event.message;
    conversation.messagesUnseen++;

    emit(state.copyWith(conversations: conversations));
    await _sortConversations(emit);
  }

  void _resetPopupDialog(ResetPopupDialog event, Emitter<ConversationListState> emit) async {
    emit(state.copyWith(
      dialogTitle: "",
      dialogMessage: ""
    ));
  }

  void _leaveGroup(LeaveGroup event, Emitter<ConversationListState> emit) async {
    if (!await _networkManager.isNetworkConnected()) {
      return emit(state.copyWith(
        dialogTitle: "Oops!",
        dialogMessage: "Network issue encountered, please check your internet connection."
      ));
    }

    emit(state.copyWith(pageLoading: true));
    final currentUserId = (await _authRepo.currentUser).id;
    final groupIndex = state.conversations.indexWhere((convo) => convo.id == event.conversationId);
    final groupConversation = state.conversations[groupIndex];
    groupConversation.userIds.removeWhere((userId) => userId == currentUserId);

    final success = await _conversationRepo.updateGroup(
      groupConversation.connectionOrGroupId,
      groupConversation.name,
      groupConversation.userIds
    );

    if (success) {
      List<Conversation> conversations = List.from(state.conversations);
      List<bool> shownConversations = List.from(state.shownConversations);
      conversations.removeAt(groupIndex);
      shownConversations.removeAt(groupIndex);

      emit(state.copyWith(
        pageLoading: false,
        conversations: conversations,
        shownConversations: shownConversations
      ));
    } else {
      emit(state.copyWith(
        pageLoading: false,
        dialogTitle: "Oops!",
        dialogMessage: "Encountered issue trying to leave group."
      ));
    }
  }

  void _pinConversation(PinConversation event, Emitter<ConversationListState> emit) async {
    await _pinOrUnpinConversation(event.conversationId, true, emit);
  }

  void _unpinConversation(UnpinConversation event, Emitter<ConversationListState> emit) async {
    await _pinOrUnpinConversation(event.conversationId, false, emit);
  }

  Future _pinOrUnpinConversation(String conversationId, bool toPin, Emitter<ConversationListState> emit) async {
    List<String> pinnedIds = List.from(state.pinnedIds);
    if (toPin) {
      pinnedIds.add(conversationId);
    } else {
      pinnedIds.removeWhere((pid) => pid == conversationId);
    }

    User currentUser = await _authRepo.currentUser;
    currentUser.pinnedConversationIds = pinnedIds;
    _authRepo.setCurrentUser(currentUser);

    await _sortConversations(emit);

    if (toPin) {
      await _conversationRepo.pinConversation(conversationId, currentUser.id);
    } else {
      await _conversationRepo.unpinConversation(conversationId, currentUser.id);
    }
  }

  Future _sortConversations(Emitter<ConversationListState> emit) async {
    List<Conversation> conversations = List.from(state.conversations);
    conversations.sort((c2, c1) => (c1.lastMessage?.sentDate ?? DateTime(1900))
      .compareTo(c2.lastMessage?.sentDate ?? DateTime(1900)));

    var pinnedIds = (await _authRepo.currentUser).pinnedConversationIds;

    conversations.sort((c1, c2) => pinnedIds
      .indexOf(c2.id)
      .compareTo(pinnedIds
      .indexOf(c1.id)));

    emit(state.copyWith(
      pinnedIds: pinnedIds,
      conversations: conversations,
      pageLoading: false
    ));
  }

  void _searchConversations(SearchConversations event, Emitter<ConversationListState> emit) {
    if (state.conversations.isEmpty) return;
    final searchTerm = event.searchTerm.toLowerCase();

    if (searchTerm == state.prevSearchTerm) {
      return emit(state.copyWith(searchSuggestions: []));
    }

    List<bool> shownConversations = List.from(state.shownConversations);
    List<String> newSuggestions = [];

    for (int i=0; i<shownConversations.length; i++) {
      if (searchTerm.isEmpty) {
        shownConversations[i] = true;
      } else if (!state.conversations[i].name.toLowerCase().contains(searchTerm)) {
        shownConversations[i] = false;
      } else {
        shownConversations[i] = true;
        if (newSuggestions.length < 5) {
          newSuggestions.add(state.conversations[i].name);
        }
      }
    }

    emit(state.copyWith(
      shownConversations: shownConversations,
      searchSuggestions: newSuggestions,
      prevSearchTerm: searchTerm
    ));
  }

  void _changeConversationsToDisplay(ChangeConversationsToDisplay event, Emitter<ConversationListState> emit) async {
    await _changeConversations(emit);
    await _sortConversations(emit);
  }

  Future _changeConversations(Emitter<ConversationListState> emit) async {
    final currentUser = await _authRepo.currentUser;
    List<Conversation> conversations = await _conversationRepo.getConversationByUser(currentUser.id);

    emit(state.copyWith(
      pinnedIds: currentUser.pinnedConversationIds,
      conversations: conversations,
      shownConversations:
      state.shownConversations.isEmpty
          || state.shownConversations.length != conversations.length
          ? List.generate(conversations.length, (_) => true)
          : state.shownConversations,
      pageLoading: true
    ));
  }
}