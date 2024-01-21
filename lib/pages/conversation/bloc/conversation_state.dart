part of 'conversation_bloc.dart';

class ConversationState extends Equatable {
  const ConversationState({
    this.conversationName = "",
    this.messages = const []
  });

  final String conversationName;
  final List<Message> messages;

  @override
  List<Object> get props => [
    conversationName, messages
  ];

  ConversationState copyWith({
    String? conversationName,
    List<Message>? messages,
  }) {
    return ConversationState(
      conversationName: conversationName ?? this.conversationName,
      messages: messages ?? this.messages
    );
  }
}