import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:recipe_social_media/entities/conversation/conversation_entities.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/conversation/conversation_repo.dart';
import 'package:equatable/equatable.dart';

export 'conversation_list_bloc.dart';
part 'conversation_list_event.dart';
part 'conversation_list_state.dart';

class ConversationListBloc extends Bloc<ConversationListEvent, ConversationListState> {
  ConversationListBloc(this._conversationRepo, this._authRepo) : super(const ConversationListState()) {
    on<ChangeConversationsToDisplay>(_changeConversationsToDisplay);
    on<SearchConversations>(_searchConversations);
  }

  final AuthenticationRepository _authRepo;
  final ConversationRepository _conversationRepo;

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
    final currentUser = await _authRepo.currentUser;
    List<Conversation> conversations = await _conversationRepo.getConversationByUser(currentUser.id);

    emit(state.copyWith(
      pinnedIds: currentUser.pinnedConversationIds,
      conversations: conversations,
      shownConversations:
        state.shownConversations.isEmpty
        || state.shownConversations.length != conversations.length
          ? List.generate(conversations.length, (_) => true)
          : state.shownConversations
    ));
  }
}