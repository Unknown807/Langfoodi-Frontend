import 'package:equatable/equatable.dart';
import 'package:recipe_social_media/repositories/navigation/args/conversation/conversation_page_arguments.dart';

enum ConversationStatus { connected, blocked, pending }

class ConversationCardContent extends Equatable {
  const ConversationCardContent({
    required this.details,
    this.lastMessage = "",
    this.lastMessageSender = "",
    this.lastMessageSentDate,
  });

  final ConversationPageArguments details;
  final String lastMessage;
  final String lastMessageSender;
  final DateTime? lastMessageSentDate;

  factory ConversationCardContent.withDefaultImage({
    required ConversationPageArguments details,
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