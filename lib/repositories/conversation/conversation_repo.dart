import 'package:recipe_social_media/api/api.dart';
import 'package:recipe_social_media/entities/conversation/conversation_entities.dart';
import 'package:recipe_social_media/utilities/utilities.dart';

export 'conversation_repo.dart';

class ConversationRepository {
  ConversationRepository(this.request, this.jsonWrapper);

  late Request request;
  late JsonWrapper jsonWrapper;

  Future<List<Conversation>> getConversationByUser(String userId) async {
    final response = await request.postWithoutBody("/conversation/get-by-user?userId=$userId");
    if (!response.isOk) return [];

    List<dynamic> jsonMessages = jsonWrapper.decodeData(response.body);
    List<Conversation> retrievedConversations = jsonMessages
      .map((jsonConvo) => Conversation.fromJson(jsonConvo))
      .toList();

    return retrievedConversations;
  }

  Future<bool> markConversationAsRead(String conversationId, String userId) async {
    final response = await request.putWithoutBody(
      "/conversation/mark-as-read?conversationId=$conversationId&userId=$userId"
    );
    return response.isOk;
  }
}