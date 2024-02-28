part of 'package:recipe_social_media/repositories/conversation/conversation_repo.dart';

class NewGroupContract with JsonConvertible {
  NewGroupContract({
    required this.name,
    required this.userIds,
    this.description = "",
  });

  final String name;
  final String description;
  final List<String> userIds;

  @override
  Map toJson() {
    return {
      "name": name,
      "description": description,
      "userIds": userIds
    };
  }
}