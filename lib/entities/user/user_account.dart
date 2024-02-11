part of 'user_entities.dart';

class UserAccount extends Equatable with JsonConvertible {
  const UserAccount(
    this.id,
    this.handler,
    this.username,
    this.creationDate,
    this.profileImageId,
    this.pinnedConversationIds
  );

  final String id;
  final String handler;
  final String username;
  final DateTime creationDate;
  final List<String> pinnedConversationIds;
  final String? profileImageId;

  static UserAccount fromJsonStr(String jsonStr, JsonWrapper jsonWrapper) {
    return UserAccount.fromJson(jsonWrapper.decodeData(jsonStr));
  }

  static UserAccount fromJson(Map jsonData) {
    return UserAccount(
      jsonData["id"],
      jsonData["handler"],
      jsonData["userName"],
      DateTime.parse(jsonData["accountCreationDate"]),
      jsonData["profileImageId"],
      (jsonData["pinnedConversationIds"] as List).map((id) => id as String).toList(),
    );
  }

  @override
  List<Object?> get props => [
    id, handler, username, creationDate,
    profileImageId
  ];
}