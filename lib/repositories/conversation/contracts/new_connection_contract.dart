part of 'package:recipe_social_media/repositories/conversation/conversation_repo.dart';

class NewConnectionContract with JsonConvertible {
  NewConnectionContract({
    required this.userId1,
    required this.userId2
  });

  final String userId1;
  final String userId2;

  @override
  Map toJson() {
    return {
      "userId1": userId1,
      "userId2": userId2
    };
  }
}