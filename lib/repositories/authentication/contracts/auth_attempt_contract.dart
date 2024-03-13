part of 'package:recipe_social_media/repositories/authentication/auth_repo.dart';

class AuthenticationAttemptContract with JsonConvertible {
  AuthenticationAttemptContract({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  Map toJson() {
    return {
      "email": email,
      "password": password
    };
  }
}