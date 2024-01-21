part of 'conversation_list_bloc.dart';

class ConversationListState extends Equatable {
  const ConversationListState({
    this.conversationCards = const [],
    this.selectedSortingOption = SortingOption.lastMessage
  });

  final List<ConversationCardContent> conversationCards;
  final SortingOption selectedSortingOption;

  @override
  List<Object?> get props => [conversationCards, selectedSortingOption];

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