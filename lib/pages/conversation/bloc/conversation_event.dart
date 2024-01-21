part of 'conversation_bloc.dart';

@immutable
sealed class ConversationEvent extends Equatable {
  const ConversationEvent();

  @override
  List<Object> get props => [];
}

final class InitState extends ConversationEvent {
  const InitState(this.conversationName, this.isGroup);

  final String conversationName;
  final bool isGroup;

  @override
  List<Object> get props => [conversationName, isGroup];
}

final class ChangeMessagesToDisplay extends ConversationEvent {
  const ChangeMessagesToDisplay();
}