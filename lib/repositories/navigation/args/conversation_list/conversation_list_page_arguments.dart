import 'package:recipe_social_media/entities/conversation/conversation_entities.dart';

class ConversationListPageArguments {
  const ConversationListPageArguments({
    required this.conversationName,
    required this.conversationStatus,
    required this.isPinned,
    required this.isGroup,
  });

  final String conversationName;
  final ConversationStatus conversationStatus;
  final bool isPinned;
  final bool isGroup;
}