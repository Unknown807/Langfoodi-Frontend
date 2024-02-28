part of 'user_entities.dart';

class UserPreviewForMessage extends Equatable with JsonConvertible {
  const UserPreviewForMessage(
    this.id,
    this.username,
    this.profileImageId
  );

  final String id;
  final String username;
  final String? profileImageId;

  static UserPreviewForMessage fromJson(Map jsonData) {
    return UserPreviewForMessage(
      jsonData["id"],
      jsonData["username"],
      jsonData["profileImageId"]
    );
  }

  @override
  List<Object?> get props => [
    id, username, profileImageId
  ];
}