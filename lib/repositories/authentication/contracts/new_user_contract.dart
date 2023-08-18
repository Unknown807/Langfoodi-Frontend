part of 'package:recipe_social_media/repositories/authentication/auth_repo.dart';

class NewUserContract {
  NewUserContract({
    required this.username,
    required this.email,
    required this.password
  });

  final String username;
  final String email;
  final String password;

  Map<String, String> toMap() {
    return {
      "username": username,
      "email": email,
      "password": password
    };
  }
}