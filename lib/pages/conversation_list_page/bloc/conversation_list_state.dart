part of 'conversation_list_bloc.dart';

class ConversationListState extends Equatable {
  const ConversationListState({
    this.conversationCards = const [],
    this.selectedSortingOption = SortingOption.lastMessage
  });

  final int numberOfConversations = 10;
  final Widget conversationDivider = const Divider(height:1, color: Color(0xFFeaeaea));

  final List<ConversationCardContent> conversationCards;
  final SortingOption selectedSortingOption;

  @override
  List<Object?> get props => [conversationCards, conversationDivider, selectedSortingOption];

  ConversationListState copyWith({
    List<ConversationCardContent>? conversationsToDisplay,
    SortingOption? selectedSortingOption
  }) {
    return ConversationListState (
        conversationCards: conversationsToDisplay ?? conversationCards,
        selectedSortingOption: selectedSortingOption ?? this.selectedSortingOption
    );
  }
}