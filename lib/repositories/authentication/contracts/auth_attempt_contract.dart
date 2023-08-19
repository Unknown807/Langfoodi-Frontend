part of 'package:recipe_social_media/repositories/authentication/auth_repo.dart';

class AuthenticationAttemptContract with JsonConvertible {
  AuthenticationAttemptContract({
    required this.usernameOrEmail,
    required this.password,
  });

  final String usernameOrEmail;
  final String password;

  @override
  Map toJson() {
    return {
      "usernameOrEmail": usernameOrEmail,
      "password": password
    };
  }
}