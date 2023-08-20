part of 'package:recipe_social_media/repositories/authentication/auth_repo.dart';

class User extends Equatable with JsonConvertible {
  const User({this.id, this.userName, this.email, this.password});

  final String? id;
  final String? userName;
  final String? email;
  final String? password;
  // TODO: Add expiry date for login

  static const empty = User();
  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;

  @override
  Map toJson() {
    return {
      "id": id,
      "userName": userName,
      "email": email,
      "password": password
    };
  }

  static User fromJson(String jsonStr, JsonWrapper jsonWrapper) {
    Map jsonData = jsonWrapper.decodeData(jsonStr);
    return User(
      id: jsonData["id"],
      userName: jsonData["userName"],
      email: jsonData["email"],
      password: jsonData["password"]
    );
  }

  @override
  List<Object?> get props => [id, userName, email, password];
}
