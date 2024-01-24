part of 'conversation_bloc.dart';

@immutable
sealed class ConversationEvent extends Equatable {
  const ConversationEvent();

  @override
  List<Object> get props => [];
}

final class InitState extends ConversationEvent {
  const InitState(this.conversationName, this.conversationStatus, this.isGroup);

  final String conversationName;
  final ConversationStatus conversationStatus;
  final bool isGroup;

  @override
  List<Object> get props => [conversationName, conversationStatus, isGroup];
}

final class GoToInteractionPageAndExpectResult extends ConversationEvent {
  const GoToInteractionPageAndExpectResult(this.context, this.arguments);

  final BuildContext context;
  final RecipeInteractionPageArguments arguments;

  @override
  List<Object> get props => [context, arguments];
}

final class ChangeMessagesToDisplay extends ConversationEvent {
  const ChangeMessagesToDisplay();
}