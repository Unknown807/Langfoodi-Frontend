import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:recipe_social_media/entities/messaging/conversation_card_content.dart';
import 'package:recipe_social_media/widgets/shared_widgets.dart';
import 'package:equatable/equatable.dart';

export 'conversation_list_bloc.dart';
part 'conversation_list_event.dart';
part 'conversation_list_state.dart';

class ConversationListBloc extends Bloc<ConversationListEvent, ConversationListState> {
  ConversationListBloc() : super(const ConversationListState()) {
    on<ChangeConversationsToDisplay>(_changeConversationsToDisplay);
    on<ChangeSelectedSortingOption>(_changeSelectedSortingOption);
    on<InitState>(_initState);
  }

  List<ConversationCardContent> conversationCards = [
    ConversationCardContent.withDefaultImage(isGroup: false, conversationName: "Connection1", conversationStatus: ConversationStatus.connected, lastMessage: "Last message...", lastMessageSender: "You", lastMessageSentDate: DateTime(2023, 11, 18), isPinned: true),
    ConversationCardContent.withDefaultImage(isGroup: false, conversationName: "Connection2", conversationStatus: ConversationStatus.connected, lastMessage: "Last message sent...", lastMessageSender: "Connection2", lastMessageSentDate: DateTime(2023, 11, 13), isPinned: true),
    ConversationCardContent.withDefaultImage(isGroup: true, conversationName: "Group1",  conversationStatus: ConversationStatus.connected, lastMessage: "Last message...", lastMessageSender: "GroupMember1", lastMessageSentDate: DateTime(2023, 11, 25), isPinned: false),
    ConversationCardContent.withDefaultImage(isGroup: true, conversationName: "Group2", conversationStatus: ConversationStatus.connected, isPinned: false),
    ConversationCardContent.withDefaultImage(isGroup: false, conversationName: "Connection3", conversationStatus: ConversationStatus.pending, lastMessage: "Last message...", lastMessageSender: "Connection3", lastMessageSentDate: DateTime(2023, 11, 12), isPinned: false),
    ConversationCardContent.withDefaultImage(isGroup: false, conversationName: "Connection4", conversationStatus: ConversationStatus.blocked, isPinned: false),
    ConversationCardContent.withDefaultImage(isGroup: true, conversationName: "Group3", conversationStatus: ConversationStatus.connected, lastMessage: "Last message sent...", lastMessageSender: "You", lastMessageSentDate: DateTime(2023, 01, 19), isPinned: false),
    ConversationCardContent.withDefaultImage(isGroup: false, conversationName: "Connection5", conversationStatus: ConversationStatus.blocked, isPinned: false)
  ];


  void _initState(InitState event, Emitter<ConversationListState> emit) async {
    emit (state.copyWith(
      conversationsToDisplay: conversationCards
    ));
  }

  Future<void> _changeConversationsToDisplay(ChangeConversationsToDisplay event, Emitter<ConversationListState> emit) async {
    emit (
      state.copyWith(
        conversationsToDisplay: conversationCards
      )
    );
  }

  Future<void> _changeSelectedSortingOption(ChangeSelectedSortingOption event, Emitter<ConversationListState> emit) async {
    final selectedSortingOption = event.selectedSortingOption;

    emit (
      state.copyWith(
        selectedSortingOption: selectedSortingOption
      )
    );
  }
}