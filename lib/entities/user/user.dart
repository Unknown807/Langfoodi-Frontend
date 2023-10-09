

import 'package:recipe_social_media/utilities/utilities.dart';
import 'package:equatable/equatable.dart';

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

  static User fromJsonStr(String jsonStr, JsonWrapper jsonWrapper) {
    return User.fromJson(jsonWrapper.decodeData(jsonStr));
  }
  
  static User fromJson(Map jsonData) {
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
