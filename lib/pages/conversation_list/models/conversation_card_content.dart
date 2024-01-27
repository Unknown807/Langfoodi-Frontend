import 'package:equatable/equatable.dart';
import 'package:recipe_social_media/repositories/navigation/args/conversation_list/conversation_list_page_arguments.dart';

class ConversationCardContent extends Equatable {
  const ConversationCardContent({
    required this.details,
    this.lastMessage = "",
    this.lastMessageSender = "",
    this.lastMessageSentDate,
  });

  final ConversationListPageArguments details;
  final String lastMessage;
  final String lastMessageSender;
  final DateTime? lastMessageSentDate;

  @override
  List<Object?> get props => [
    details, lastMessage, lastMessageSender, lastMessageSentDate
  ];
}