import 'package:recipe_social_media/entities/conversation/conversation_entities.dart';

class ConversationPageArguments {
  const ConversationPageArguments({
    required this.conversation,
    required this.isBlocked
  });

  final Conversation conversation;
  final bool isBlocked;
}