part of 'package:recipe_social_media/repositories/authentication/auth_repo.dart';

class User extends Equatable implements JsonConvertible {
  const User({this.id, this.userName, this.email, this.password});

  final String? id;
  final String? userName;
  final String? email;
  final String? password;
  // TODO: Add expiry date for login

  static const empty = User();
  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;

  factory User.fromJson(Map<String, dynamic> jsonData) {
    return User(
      id: jsonData["id"],
      userName: jsonData["userName"],
      email: jsonData["email"],
      password: jsonData["password"]
    );
  }

  @override
  Map toJson() {
    return {
      "id": id,
      "userName": userName,
      "email": email,
      "password": password
    };
  }

  static String serialize(User user, JsonWrapper jsonWrapper) {
    return jsonWrapper.encodeData(user);
  }

  static User deserialize(String jsonStr, JsonWrapper jsonWrapper) {
    return User.fromJson(jsonWrapper.decodeData(jsonStr));
  }

  @override
  List<Object?> get props => [id, userName, email, password];
}
