import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:recipe_social_media/entities/messaging/conversation_card_content.dart';
import 'package:recipe_social_media/entities/messaging/conversation_details.dart';
import 'package:recipe_social_media/repositories/navigation/navigation_repo.dart';
import 'package:recipe_social_media/widgets/shared_widgets.dart';
import 'package:equatable/equatable.dart';

part 'conversation_list_event.dart';
part 'conversation_list_state.dart';

class ConversationListBloc extends Bloc<ConversationListEvent, ConversationListState> {
  ConversationListBloc(this._navigationRepo) : super(const ConversationListState()) {
    on<ChangeConversationsToDisplay>(_changeConversationsToDisplay);
    on<NavigateToConversation>(_navigateToConversation);
    on<ChangeSelectedSortingOption>(_changeSelectedSortingOption);
    on<InitState>(_initState);
  }

  final NavigationRepository _navigationRepo;

  List<ConversationCardContent> conversationCards = [
    ConversationCardContent.withDefaultImage(details: const ConversationDetails(isGroup: false, conversationName: "Connection1", conversationStatus: ConversationStatus.connected, isPinned: true), lastMessage: "Last message...", lastMessageSender: "You", lastMessageSentDate: DateTime(2023, 11, 18)),
    ConversationCardContent.withDefaultImage(details: const ConversationDetails(isGroup: false, conversationName: "Connection2", conversationStatus: ConversationStatus.connected, isPinned: true), lastMessage: "Last message sent...", lastMessageSender: "Connection2", lastMessageSentDate: DateTime(2023, 11, 13)),
    ConversationCardContent.withDefaultImage(details: const ConversationDetails(isGroup: true, conversationName: "Group1", conversationStatus: ConversationStatus.connected, isPinned: false), lastMessage: "Last message...", lastMessageSender: "GroupMember1", lastMessageSentDate: DateTime(2023, 11, 25)),
    ConversationCardContent.withDefaultImage(details: const ConversationDetails(isGroup: true, conversationName: "Group2", conversationStatus: ConversationStatus.connected, isPinned: false)),
    ConversationCardContent.withDefaultImage(details: const ConversationDetails(isGroup: false, conversationName: "Connection3", conversationStatus: ConversationStatus.pending, isPinned: false), lastMessage: "Last message...", lastMessageSender: "Connection3", lastMessageSentDate: DateTime(2023, 11, 12)),
    ConversationCardContent.withDefaultImage(details: const ConversationDetails(isGroup: false, conversationName: "Connection4", conversationStatus: ConversationStatus.blocked, isPinned: false)),
    ConversationCardContent.withDefaultImage(details: const ConversationDetails(isGroup: true, conversationName: "Group3", conversationStatus: ConversationStatus.connected, isPinned: false), lastMessage: "Last message sent...", lastMessageSender: "You", lastMessageSentDate: DateTime(2023, 01, 19)),
    ConversationCardContent.withDefaultImage(details: const ConversationDetails(isGroup: false, conversationName: "Connection5", conversationStatus: ConversationStatus.blocked, isPinned: false)),
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

  Future<void> _navigateToConversation(NavigateToConversation event, Emitter<ConversationListState> emit) async {
    BuildContext eventContext = event.context;
    await _navigationRepo.goTo(
        eventContext,
        "/conversation",
        routeType: RouteType.expect,
        arguments: event.conversationDetails);
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