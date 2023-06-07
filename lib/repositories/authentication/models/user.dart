import 'package:equatable/equatable.dart';
import 'package:recipe_social_media/utilities/utilities.dart';

class User extends Equatable {
  const User({this.userName, this.email, this.password});

  final String? userName;
  final String? email;
  final String? password;
  // TODO: Add expiry date for login

  static const empty = User();
  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;

  factory User.fromJson(Map<String, String?> jsonData) {
    return User(
      userName: jsonData["userName"],
      email: jsonData["email"],
      password: jsonData["password"]
    );
  }

  static Map<String, String?> toMap(User user) {
    return <String, String?> {
      "userName": user.userName,
      "email": user.email,
      "password": user.password
    };
  }

  static String serialize(User user, JsonWrapper jsonWrapper) {
    return jsonWrapper.encodeData(User.toMap(user));
  }

  static User deserialize(String jsonStr, JsonWrapper jsonWrapper) {
    return User.fromJson(jsonWrapper.decodeData(jsonStr));
  }

  @override
  List<Object?> get props => [userName, email, password];
}
