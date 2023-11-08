part of 'package:recipe_social_media/repositories/authentication/auth_repo.dart';

class NewUserContract with JsonConvertible {
  NewUserContract({
    required this.handler,
    required this.username,
    required this.email,
    required this.password
  });

  final String handler;
  final String username;
  final String email;
  final String password;

  @override
  Map toJson() {
    return {
      "handler": handler,
      "username": username,
      "email": email,
      "password": password
    };
  }
}