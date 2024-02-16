part of 'conversation_list_bloc.dart';

class ConversationListState extends Equatable {
  const ConversationListState({
    this.conversations = const [],
    this.shownConversations = const [],
    this.searchSuggestions = const [],
    this.prevSearchTerm = "",
    this.selectedSortingOption = SortingOption.lastMessage
  });

  final List<Conversation> conversations;
  final List<bool> shownConversations;
  final List<String> searchSuggestions;
  final SortingOption selectedSortingOption;
  final String prevSearchTerm;

  @override
  List<Object?> get props => [
    conversations, selectedSortingOption, shownConversations,
    searchSuggestions, prevSearchTerm
  ];

  ConversationListState copyWith({
    List<Conversation>? conversations,
    SortingOption? selectedSortingOption,
    List<bool>? shownConversations,
    List<String>? searchSuggestions,
    String? prevSearchTerm
  }) {
    return ConversationListState (
      conversations: conversations ?? this.conversations,
      selectedSortingOption: selectedSortingOption ?? this.selectedSortingOption,
      shownConversations: shownConversations ?? this.shownConversations,
      searchSuggestions: searchSuggestions ?? this.searchSuggestions,
      prevSearchTerm: prevSearchTerm ?? this.prevSearchTerm
    );
  }
}