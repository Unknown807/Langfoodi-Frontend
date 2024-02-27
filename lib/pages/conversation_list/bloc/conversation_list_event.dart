part of 'conversation_list_bloc.dart';

@immutable
sealed class ConversationListEvent extends Equatable {
  const ConversationListEvent();

  @override
  List<Object> get props => [];
}

final class ChangeConversationsToDisplay extends ConversationListEvent {
  const ChangeConversationsToDisplay();
}

final class SearchConversations extends ConversationListEvent {
  const SearchConversations(this.searchTerm);

  final String searchTerm;

  @override
  List<Object> get props => [searchTerm];
}

final class BlockConnection extends ConversationListEvent {
  const BlockConnection(this.connectionId);

  final String connectionId;

  @override
  List<Object> get props => [connectionId];
}

final class UnblockConnection extends ConversationListEvent {
  const UnblockConnection(this.connectionId);

  final String connectionId;

  @override
  List<Object> get props => [connectionId];
}

final class PinConversation extends ConversationListEvent {
  const PinConversation(this.conversationId);

  final String conversationId;

  @override
  List<Object> get props => [conversationId];
}

final class UnpinConversation extends ConversationListEvent {
  const UnpinConversation(this.conversationId);

  final String conversationId;

  @override
  List<Object> get props => [conversationId];
}

final class LeaveGroup extends ConversationListEvent {
  const LeaveGroup(this.conversationId);

  final String conversationId;

  @override
  List<Object> get props => [conversationId];
}

final class ResetPopupDialog extends ConversationListEvent {
  const ResetPopupDialog();
}