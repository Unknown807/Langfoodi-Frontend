import 'package:recipe_social_media/api/api.dart';
import 'package:recipe_social_media/utilities/utilities.dart';

export 'message_repo.dart';

class MessageRepository {
  MessageRepository(this.request, this.jsonWrapper);

  late Request request;
  late JsonWrapper jsonWrapper;
}