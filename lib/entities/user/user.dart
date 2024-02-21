part of 'user_entities.dart';

class User extends Equatable with JsonConvertible {
  User(
    this.id,
    this.handler,
    this.username,
    this.email,
    this.password,
    this.creationDate,
    this.profileImageId,
    this.pinnedConversationIds
  );

  final String id;
  final String handler;
  final String username;
  final String email;
  final String password;
  final DateTime creationDate;
  final String? profileImageId;
  List<String> pinnedConversationIds;
  // TODO: Add expiry date for login?

  @override
  Map toJson() {
    return {
      "id": id,
      "handler": handler,
      "userName": username,
      "email": email,
      "password": password,
      "accountCreationDate": creationDate.toString(),
      "profileImageId": profileImageId,
      "pinnedConversationIds": pinnedConversationIds
    };
  }

  static User fromJsonStr(String jsonStr, JsonWrapper jsonWrapper) {
    return User.fromJson(jsonWrapper.decodeData(jsonStr));
  }
  
  static User fromJson(Map jsonData) {
    return User(
      jsonData["id"],
      jsonData["handler"],
      jsonData["userName"],
      jsonData["email"],
      jsonData["password"],
      DateTime.parse(jsonData["accountCreationDate"]),
      jsonData["profileImageId"],
      (jsonData["pinnedConversationIds"] as List).map((id) => id as String).toList(),
    );
  }

  @override
  List<Object?> get props => [
    id, handler, username, email,
    password, creationDate, profileImageId,
    pinnedConversationIds
  ];
}
