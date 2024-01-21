part of 'conversation_bloc.dart';

class ConversationState extends Equatable {
  const ConversationState({
    this.conversationName = "",
    this.isGroup = false,
    this.messages = const []
  });

  final String conversationName;
  final bool isGroup;
  final List<Message> messages;

  @override
  List<Object> get props => [
    conversationName, messages, isGroup
  ];

  ConversationState copyWith({
    String? conversationName,
    List<Message>? messages,
    bool? isGroup,
  }) {
    return ConversationState(
      conversationName: conversationName ?? this.conversationName,
      messages: messages ?? this.messages,
      isGroup: isGroup ?? this.isGroup
    );
  }
}