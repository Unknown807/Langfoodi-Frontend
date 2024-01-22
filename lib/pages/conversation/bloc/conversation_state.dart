part of 'conversation_bloc.dart';

class ConversationState extends Equatable {
  const ConversationState({
    this.conversationName = "",
    this.conversationStatus = ConversationStatus.connected,
    this.isGroup = false,
    this.messages = const [],
    this.senderId = "",
    this.nameColours = const {}
  });

  final ConversationStatus conversationStatus;
  final String senderId;
  final String conversationName;
  final bool isGroup;
  final List<Message> messages;
  final Map<String, Color> nameColours;

  @override
  List<Object> get props => [
    conversationName, messages, isGroup,
    senderId, conversationStatus, nameColours
  ];

  ConversationState copyWith({
    String? conversationName,
    List<Message>? messages,
    bool? isGroup,
    String? senderId,
    ConversationStatus? conversationStatus,
    Map<String, Color>? nameColours,
  }) {
    return ConversationState(
      conversationName: conversationName ?? this.conversationName,
      messages: messages ?? this.messages,
      isGroup: isGroup ?? this.isGroup,
      senderId: senderId ?? this.senderId,
      conversationStatus: conversationStatus ?? this.conversationStatus,
      nameColours: nameColours ?? this.nameColours
    );
  }
}