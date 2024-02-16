import 'package:recipe_social_media/api/api.dart';
import 'package:recipe_social_media/utilities/utilities.dart';

export 'conversation_repo.dart';

class ConversationRepository {
  ConversationRepository(this.request, this.jsonWrapper);

  late Request request;
  late JsonWrapper jsonWrapper;

  Future<bool> markConversationAsRead(String conversationId, String userId) async {
    final response = await request.putWithoutBody(
      "/conversation/mark-as-read?conversationId=$conversationId&userId=$userId"
    );
    return response.isOk;
  }
}