part of 'conversation_entities.dart';

class Conversation extends Equatable with JsonConvertible {
  const Conversation(
    this.id,
    this.connectionOrGroupId,
    this.name,
    this.thumbnailId,
    this.isGroup,
    this.lastMessage,
    this.messagesUnseen
  );

  final String id;
  final String connectionOrGroupId;
  final String name;
  final bool isGroup;
  final List<int> messagesUnseen;
  final String? thumbnailId;
  final Message? lastMessage;

  static Conversation fromJson(Map jsonData) {
    return Conversation(
      jsonData["id"],
      jsonData["connectionOrGroupId"],
      jsonData["name"],
      jsonData["thumbnailId"],
      jsonData["isGroup"],
      jsonData["lastMessage"] != null ? Message.fromJson(jsonData["lastMessage"]) : null,
      jsonData["messagesUnseen"]
    );
  }

  @override
  List<Object?> get props => [
    id, connectionOrGroupId, name, isGroup,
    messagesUnseen, thumbnailId, lastMessage
  ];
}