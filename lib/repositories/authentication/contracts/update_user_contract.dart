part of 'package:recipe_social_media/repositories/authentication/auth_repo.dart';

class UpdateUserContract with JsonConvertible {
  UpdateUserContract({
    required this.id,
    required this.username,
    required this.email,
    required this.password
  });

  final String id;
  final String username;
  final String email;
  final String password;

  @override
  Map toJson() {
    return {
      "id": id,
      "username": username,
      "email": email,
      "password": password
    };
  }
}