import 'package:recipe_social_media/api/api.dart';
import 'package:recipe_social_media/entities/conversation/conversation_entities.dart';
import 'package:recipe_social_media/utilities/utilities.dart';

export 'message_repo.dart';
part 'contracts/new_message_contract.dart';

class MessageRepository {
  MessageRepository(this.request, this.jsonWrapper);

  late Request request;
  late JsonWrapper jsonWrapper;

  Future<List<Message>> getMessagesFromConversation(String conversationId) async {
    final response = await request.postWithoutBody("/message/get-by-conversation?conversationId=$conversationId");
    if (!response.isOk) return [];

    List<dynamic> jsonMessages = jsonWrapper.decodeData(response.body);
    List<Message> retrievedMessages = jsonMessages
      .map((jsonMsg) => Message.fromJson(jsonMsg))
      .toList();

    return retrievedMessages;
  }

  Future<Message?> sendMessage(NewMessageContract contract) async {
    final response = await request.post("/message/send", contract, jsonWrapper);
    if (!response.isOk) return null;

    return Message.fromJsonStr(response.body, jsonWrapper);
  }
}