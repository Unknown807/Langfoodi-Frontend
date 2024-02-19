import 'package:recipe_social_media/api/api.dart';
import 'package:recipe_social_media/entities/conversation/conversation_entities.dart';
import 'package:recipe_social_media/utilities/utilities.dart';

export 'conversation_repo.dart';
part 'contracts/new_connection_contract.dart';

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

  Future<Connection?> createConnection(String userId1, String userId2) async {
    final contract = NewConnectionContract(userId1: userId1, userId2: userId2);
    final response = await request.post("/connection/create", contract, jsonWrapper);
    if (!response.isOk) return null;

    return Connection.fromJsonStr(response.body, jsonWrapper);
  }

  Future<Conversation?> createConversationByConnection(String connectionId, String userId) async {
    final response = await request.putWithoutBody(
      "/conversation/create-by-connection?connectionId=$connectionId&userId=$userId"
    );
    if (!response.isOk) return null;

    return Conversation.fromJsonStr(response.body, jsonWrapper);
  }
}