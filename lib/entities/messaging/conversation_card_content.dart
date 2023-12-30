import 'package:equatable/equatable.dart';

enum ConversationStatus { connected, blocked, pending }

class ConversationCardContent extends Equatable {
  const ConversationCardContent({
    required this.conversationName,
    required this.conversationStatus,
    required this.isPinned,
    required this.isGroup,
    this.lastMessage = "",
    this.lastMessageSender = "",
    this.lastMessageSentDate,
  });

  final String conversationName;
  final ConversationStatus conversationStatus;
  final String lastMessage;
  final String lastMessageSender;
  final DateTime? lastMessageSentDate;
  final bool isPinned;
  final bool isGroup;

  factory ConversationCardContent.withDefaultImage({
    required String conversationName,
    required ConversationStatus conversationStatus,
    String lastMessage = "",
    String lastMessageSender = "",
    DateTime? lastMessageSentDate,
    required bool isPinned,
    required bool isGroup,
  }) {
    return ConversationCardContent(
      conversationName: conversationName,
      conversationStatus: conversationStatus,
      lastMessage: lastMessage,
      lastMessageSender: lastMessageSender,
      lastMessageSentDate: lastMessageSentDate,
      isPinned: isPinned,
      isGroup: isGroup
    );
  }

  @override
  List<Object?> get props => [
    conversationName, conversationStatus, lastMessage,
    lastMessageSender, lastMessageSentDate, isPinned
  ];
}