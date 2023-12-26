part of 'package:recipe_social_media/repositories/authentication/auth_repo.dart';

class AuthenticationAttemptContract with JsonConvertible {
  AuthenticationAttemptContract({
    required this.handlerOrEmail,
    required this.password,
  });

  final String handlerOrEmail;
  final String password;

  @override
  Map toJson() {
    return {
      "handlerOrEmail": handlerOrEmail,
      "password": password
    };
  }
}