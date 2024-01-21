import 'package:recipe_social_media/pages/conversation_list/models/conversation_card_content.dart';

class ConversationPageArguments {
  const ConversationPageArguments({
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