import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:recipe_social_media/entities/conversation/conversation_entities.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/conversation/conversation_repo.dart';
import 'package:recipe_social_media/widgets/shared_widgets.dart';
import 'package:equatable/equatable.dart';

export 'conversation_list_bloc.dart';
part 'conversation_list_event.dart';
part 'conversation_list_state.dart';

class ConversationListBloc extends Bloc<ConversationListEvent, ConversationListState> {
  ConversationListBloc(this._conversationRepo, this._authRepo) : super(const ConversationListState()) {
    on<ChangeConversationsToDisplay>(_changeConversationsToDisplay);
    on<ChangeSelectedSortingOption>(_changeSelectedSortingOption);
  }

  final AuthenticationRepository _authRepo;
  final ConversationRepository _conversationRepo;


  void _changeConversationsToDisplay(ChangeConversationsToDisplay event, Emitter<ConversationListState> emit) async {
    final userId = (await _authRepo.currentUser).id;
    List<Conversation> conversations = await _conversationRepo.getConversationByUser(userId);
    emit(state.copyWith(conversations: conversations));
  }

  void _changeSelectedSortingOption(ChangeSelectedSortingOption event, Emitter<ConversationListState> emit) async {
    emit(state.copyWith(
      selectedSortingOption: event.selectedSortingOption
    ));
  }
}