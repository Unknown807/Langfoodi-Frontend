part of 'conversation_list_bloc.dart';

class ConversationListState extends Equatable {
  const ConversationListState({
    this.conversations = const [],
    this.selectedSortingOption = SortingOption.lastMessage
  });

  final List<Conversation> conversations;
  final SortingOption selectedSortingOption;

  @override
  List<Object?> get props => [conversations, selectedSortingOption];

  ConversationListState copyWith({
    List<Conversation>? conversations,
    SortingOption? selectedSortingOption
  }) {
    return ConversationListState (
      conversations: conversations ?? this.conversations,
      selectedSortingOption: selectedSortingOption ?? this.selectedSortingOption
    );
  }
}