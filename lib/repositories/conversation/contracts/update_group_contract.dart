part of 'package:recipe_social_media/repositories/conversation/conversation_repo.dart';

class UpdateGroupContract with JsonConvertible {
  UpdateGroupContract({
    required this.groupId,
    required this.groupName,
    required this.userIds,
    this.groupDescription = ""
  });

  final String groupId;
  final String groupName;
  final List<String> userIds;
  final String groupDescription;

  @override
  Map toJson() {
    return {
      "groupId": groupId,
      "groupName": groupName,
      "groupDescription": groupDescription,
      "userIds": userIds
    };
  }
}