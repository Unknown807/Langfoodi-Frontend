part of 'package:recipe_social_media/repositories/authentication/auth_repo.dart';

class UpdateUserContract with JsonConvertible {
  UpdateUserContract({
    required this.id,
    this.username,
    this.email,
    this.password,
    this.profileImageId
  });

  final String id;
  final String? profileImageId;
  final String? username;
  final String? email;
  final String? password;

  @override
  Map toJson() {
    return {
      "id": id,
      "profileImageId": profileImageId,
      "username": username,
      "email": email,
      "password": password
    };
  }
}