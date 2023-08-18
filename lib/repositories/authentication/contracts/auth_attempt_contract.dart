part of 'package:recipe_social_media/repositories/authentication/auth_repo.dart';

class AuthenticationAttemptContract {
  AuthenticationAttemptContract({
    required this.usernameOrEmail,
    required this.password,
  });

  final String usernameOrEmail;
  final String password;

  Map<String, String> toMap() {
    return {
      "usernameOrEmail": usernameOrEmail,
      "password": password
    };
  }
}