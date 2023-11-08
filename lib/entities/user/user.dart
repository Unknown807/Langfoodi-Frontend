import 'package:recipe_social_media/utilities/utilities.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable with JsonConvertible {
  const User(
      this.id,
      this.handler,
      this.username,
      this.email,
      this.password,
      this.creationDate);

  final String id;
  final String handler;
  final String username;
  final String email;
  final String password;
  final DateTime creationDate;
  // TODO: Add expiry date for login?

  @override
  Map toJson() {
    return {
      "id": id,
      "handler": handler,
      "username": username,
      "email": email,
      "password": password,
      "accountCreationDate": creationDate
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
      jsonData["accountCreationDate"]
    );
  }

  @override
  List<Object?> get props => [
    id, handler, username, email,
    password, creationDate
  ];
}
