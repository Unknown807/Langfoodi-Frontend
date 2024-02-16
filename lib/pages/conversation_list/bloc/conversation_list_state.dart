part of 'conversation_list_bloc.dart';

class ConversationListState extends Equatable {
  const ConversationListState({
    this.conversations = const [],
    this.shownConversations = const [],
    this.searchSuggestions = const [],
    this.pinnedIds = const [],
    this.prevSearchTerm = "",
  });

  final List<Conversation> conversations;
  final List<bool> shownConversations;
  final List<String> searchSuggestions;
  final List<String> pinnedIds;
  final String prevSearchTerm;

  @override
  List<Object?> get props => [
    conversations, shownConversations,
    searchSuggestions, prevSearchTerm,
    pinnedIds
  ];

  ConversationListState copyWith({
    List<Conversation>? conversations,
    List<bool>? shownConversations,
    List<String>? searchSuggestions,
    String? prevSearchTerm,
    List<String>? pinnedIds
  }) {
    return ConversationListState (
      conversations: conversations ?? this.conversations,
      shownConversations: shownConversations ?? this.shownConversations,
      searchSuggestions: searchSuggestions ?? this.searchSuggestions,
      prevSearchTerm: prevSearchTerm ?? this.prevSearchTerm,
      pinnedIds: pinnedIds ?? this.pinnedIds
    );
  }
}