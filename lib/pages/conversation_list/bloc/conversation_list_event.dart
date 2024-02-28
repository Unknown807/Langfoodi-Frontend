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

final class ReceiveMessage extends ConversationListEvent {
  const ReceiveMessage(this.message, this.conversationId);

  final Message message;
  final String conversationId;

  @override
  List<Object> get props => [message, conversationId];
}

final class GoToAddConnectionPageAndExpectResult extends ConversationListEvent {
  const GoToAddConnectionPageAndExpectResult(this.context);

  final BuildContext context;

  @override
  List<Object> get props => [context];
}

final class GoToAddGroupPageAndExpectResult extends ConversationListEvent {
  const GoToAddGroupPageAndExpectResult(this.context);

  final BuildContext context;

  @override
  List<Object> get props => [context];
}

final class GoToConversationPageAndExpectResult extends ConversationListEvent {
  const GoToConversationPageAndExpectResult(this.context, this.arguments);

  final BuildContext context;
  final ConversationPageArguments arguments;

  @override
  List<Object> get props => [context, arguments];
}