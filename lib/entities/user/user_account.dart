part of 'user_entities.dart';

class UserAccount extends Equatable with JsonConvertible {
  const UserAccount(
    this.id,
    this.handler,
    this.username,
    this.creationDate
  );

  final String id;
  final String handler;
  final String username;
  final DateTime creationDate;

  static UserAccount fromJsonStr(String jsonStr, JsonWrapper jsonWrapper) {
    return UserAccount.fromJson(jsonWrapper.decodeData(jsonStr));
  }

  static UserAccount fromJson(Map jsonData) {
    return UserAccount(
        jsonData["id"],
        jsonData["handler"],
        jsonData["userName"],
        DateTime.parse(jsonData["accountCreationDate"])
    );
  }

  @override
  List<Object?> get props => [id, handler, username, creationDate];
}