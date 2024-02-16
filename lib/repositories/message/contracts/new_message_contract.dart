part of 'package:recipe_social_media/repositories/message/message_repo.dart';

class NewMessageContract with JsonConvertible {
  NewMessageContract({
    required this.conversationId,
    required this.senderId,
    this.text,
    this.recipeIds,
    this.imageURLs,
    this.messageRepliedToId
  });

  final String conversationId;
  final String senderId;
  final String? text;
  final String? messageRepliedToId;
  final List<String>? recipeIds;
  final List<String>? imageURLs;

  @override
  Map toJson() {
    return {
      "conversationId": conversationId,
      "senderId": senderId,
      "text": text,
      "recipeIds": recipeIds,
      "imageURLs": imageURLs,
      "messageRepliedToId": messageRepliedToId
    };
  }
}