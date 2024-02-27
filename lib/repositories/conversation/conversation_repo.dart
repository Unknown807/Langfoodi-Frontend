import 'dart:io';

import 'package:recipe_social_media/api/api.dart';
import 'package:recipe_social_media/entities/conversation/conversation_entities.dart';
import 'package:recipe_social_media/utilities/utilities.dart';

export 'conversation_repo.dart';
part 'contracts/new_connection_contract.dart';
part 'contracts/new_group_contract.dart';
part 'contracts/update_group_contract.dart';

class ConversationRepository {
  ConversationRepository(this.request, this.jsonWrapper);

  late Request request;
  late JsonWrapper jsonWrapper;

  Future<List<Conversation>> getConversationByUser(String userId) async {
    final response = await request.postWithoutBody("/conversation/get-by-user?userId=$userId", headers: { HttpHeaders.authorizationHeader: await request.currentToken });
    if (!response.isOk) return [];

    List<dynamic> jsonMessages = jsonWrapper.decodeData(response.body);
    List<Conversation> retrievedConversations = jsonMessages
      .map((jsonConvo) => Conversation.fromJson(jsonConvo))
      .toList();

    return retrievedConversations;
  }

  Future<bool> markConversationAsRead(String conversationId, String userId) async {
    final response = await request.putWithoutBody(
      "/conversation/mark-as-read?conversationId=$conversationId&userId=$userId",
        headers: { HttpHeaders.authorizationHeader: await request.currentToken }
    );
    return response.isOk;
  }

  Future<Connection?> createConnection(String userId1, String userId2) async {
    final contract = NewConnectionContract(userId1: userId1, userId2: userId2);
    final response = await request.post("/connection/create", contract, jsonWrapper, headers: { HttpHeaders.authorizationHeader: await request.currentToken });
    if (!response.isOk) return null;

    return Connection.fromJsonStr(response.body, jsonWrapper);
  }

  Future<Conversation?> _createConversation(String path) async {
    final response = await request.postWithoutBody(path, headers: { HttpHeaders.authorizationHeader: await request.currentToken });
    if (!response.isOk) return null;

    return Conversation.fromJsonStr(response.body, jsonWrapper);
  }

  Future<Conversation?> createConversationByConnection(String connectionId, String userId) async {
    return _createConversation("/conversation/create-by-connection?connectionId=$connectionId&userId=$userId");
  }

  Future<Conversation?> createConversationByGroup(String groupId, String userId) async {
    return _createConversation("/conversation/create-by-group?groupId=$groupId&userId=$userId");
  }

  Future<Group?> createGroup(String groupName, List<String> userIds) async {
    final contract = NewGroupContract(name: groupName, userIds: userIds);
    final response = await request.post("/group/create", contract, jsonWrapper, headers: { HttpHeaders.authorizationHeader: await request.currentToken });
    if (!response.isOk) return null;

    return Group.fromJsonStr(response.body, jsonWrapper);
  }

  Future<bool> updateGroup(String groupId, String groupName, List<String> userIds) async {
    final contract = UpdateGroupContract(groupId: groupId, groupName: groupName, userIds: userIds);
    final response = await request.put("/group/update", contract, jsonWrapper, headers: { HttpHeaders.authorizationHeader: await request.currentToken });
    return response.isOk;
  }

  Future<bool> deleteGroup(String groupId) async {
    final response = await request.delete("/group/delete?groupId=$groupId", headers: { HttpHeaders.authorizationHeader: await request.currentToken });
    return response.isOk;
  }

  Future<bool> unpinConversation(String conversationId, String userId) async {
    final response = await request.postWithoutBody(
      "/user/unpin?conversationId=$conversationId&userId=$userId",
        headers: { HttpHeaders.authorizationHeader: await request.currentToken }
    );
    return response.isOk;
  }

  Future<bool> pinConversation(String conversationId, String userId) async {
    final response = await request.postWithoutBody(
        "/user/pin?conversationId=$conversationId&userId=$userId",
        headers: { HttpHeaders.authorizationHeader: await request.currentToken }
    );
    return response.isOk;
  }
}