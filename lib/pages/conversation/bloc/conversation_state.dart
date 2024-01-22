part of 'conversation_bloc.dart';

class ConversationState extends Equatable {
  const ConversationState({
    this.conversationName = "",
    this.isGroup = false,
    this.messages = const [],
    this.senderId = "",
  });

  final String senderId;
  final String conversationName;
  final bool isGroup;
  final List<Message> messages;

  @override
  List<Object> get props => [
    conversationName, messages, isGroup,
    senderId
  ];

  ConversationState copyWith({
    String? conversationName,
    List<Message>? messages,
    bool? isGroup,
    String? senderId
  }) {
    return ConversationState(
      conversationName: conversationName ?? this.conversationName,
      messages: messages ?? this.messages,
      isGroup: isGroup ?? this.isGroup,
      senderId: senderId ?? this.senderId
    );
  }
}