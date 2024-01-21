part of 'conversation_entities.dart';

enum ConversationStatus { connected, blocked, pending }

class ConversationCardContent extends Equatable {
  const ConversationCardContent({
    required this.details,
    this.lastMessage = "",
    this.lastMessageSender = "",
    this.lastMessageSentDate,
  });

  final Conversation details;
  final String lastMessage;
  final String lastMessageSender;
  final DateTime? lastMessageSentDate;

  factory ConversationCardContent.withDefaultImage({
    required ConversationDetails details,
    String lastMessage = "",
    String lastMessageSender = "",
    DateTime? lastMessageSentDate,
  }) {
    return ConversationCardContent(
      details: details,
      lastMessage: lastMessage,
      lastMessageSender: lastMessageSender,
      lastMessageSentDate: lastMessageSentDate,
    );
  }

  @override
  List<Object?> get props => [
    details, lastMessage, lastMessageSender, lastMessageSentDate
  ];
}