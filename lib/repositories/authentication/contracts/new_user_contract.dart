part of 'package:recipe_social_media/repositories/authentication/auth_repo.dart';

class NewUserContract implements Contract {
  NewUserContract({
    required this.username,
    required this.email,
    required this.password
  });

  final String username;
  final String email;
  final String password;

  @override
  Map toJson() {
    return {
      "username": username,
      "email": email,
      "password": password
    };
  }
}