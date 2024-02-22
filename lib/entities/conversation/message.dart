part of 'conversation_entities.dart';

class Message extends Equatable with JsonConvertible {
  const Message(
    this.id,
    this.userPreview,
    this.seenByUserIds,
    this.sentDate,
    this.updatedDate,
    this.repliedToMessageId,
    this.textContent,
    this.imageURLs,
    this.recipes,
  );

  final String id;
  final UserPreviewForMessage userPreview;
  final List<String> seenByUserIds;
  final DateTime? sentDate;
  final DateTime? updatedDate;
  final String? repliedToMessageId;
  final String? textContent;
  final List<String>? imageURLs;
  final List<RecipePreview>? recipes;

  static Message fromJsonStr(String jsonStr, JsonWrapper jsonWrapper) {
    return Message.fromJson(jsonWrapper.decodeData(jsonStr));
  }

  static Message fromJson(Map jsonData) {
    return Message(
      jsonData["id"],
      UserPreviewForMessage.fromJson(jsonData["userPreview"]),
      (jsonData["seenByUserIds"] as List).map((id) => id as String).toList(),
      jsonData["sentDate"] != null ? DateTime.parse(jsonData["sentDate"]) : null,
      jsonData["updatedDate"] != null ? DateTime.parse(jsonData["updatedDate"]) : null,
      jsonData["repliedToMessageId"],
      jsonData["textContent"],
      (jsonData["imageURLs"] as List?)?.map((url) => url as String).toList(),
      jsonData["recipes"]?.map<RecipePreview>((r) => RecipePreview.fromJson(r)).toList()
    );
  }

  @override
  List<Object?> get props => [
    id, sentDate, updatedDate,
    repliedToMessageId, textContent, imageURLs,
    recipes, userPreview
  ];
}