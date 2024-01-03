import 'package:equatable/equatable.dart';
import 'package:recipe_social_media/entities/messaging/conversation_card_content.dart';

class ConversationDetails extends Equatable {
  const ConversationDetails({
    required this.conversationName,
    required this.conversationStatus,
    required this.isPinned,
    required this.isGroup,
  });

  final String conversationName;
  final ConversationStatus conversationStatus;
  final bool isPinned;
  final bool isGroup;

  @override
  List<Object?> get props => [
    conversationName, conversationStatus, isPinned, isGroup
  ];
}