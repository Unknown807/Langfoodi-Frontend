part of 'conversation_entities.dart';

class Conversation with JsonConvertible {
  Conversation(
    this.id,
    this.connectionOrGroupId,
    this.name,
    this.thumbnailId,
    this.isGroup,
    this.lastMessage,
    this.messagesUnseen,
    this.userIds
  );

  final String id;
  final String connectionOrGroupId;
  final String name;
  final bool isGroup;
  int messagesUnseen;
  final String? thumbnailId;
  Message? lastMessage;
  final List<String> userIds;

  static Conversation fromJsonStr(String jsonStr, JsonWrapper jsonWrapper) {
    return Conversation.fromJson(jsonWrapper.decodeData(jsonStr));
  }

  static Conversation fromJson(Map jsonData) {
    return Conversation(
      jsonData["id"],
      jsonData["connectionOrGroupId"],
      jsonData["name"],
      jsonData["thumbnailId"],
      jsonData["isGroup"],
      jsonData["lastMessage"] != null ? Message.fromJson(jsonData["lastMessage"]) : null,
      jsonData["messagesUnseen"],
      (jsonData["userIds"] as List).map((id) => id as String).toList()
    );
  }

  @override
  List<Object?> get props => [
    id, connectionOrGroupId, name, isGroup,
    messagesUnseen, thumbnailId, lastMessage,
    userIds
  ];
}