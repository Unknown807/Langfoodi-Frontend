part of 'conversation_entities.dart';

class Message extends Equatable with JsonConvertible {
  const Message(
    this.id,
    this.senderId,
    this.senderName,
    this.seenByUserIds,
    this.sentDate,
    this.updatedDate,
    this.repliedToMessageId,
    this.textContent,
    this.imageURLs,
    this.recipePreviews
  );

  final String id;
  final String senderId;
  final String senderName;
  final List<String> seenByUserIds;
  final DateTime? sentDate;
  final DateTime? updatedDate;
  final String? repliedToMessageId;
  final String? textContent;
  final List<String>? imageURLs;
  final List<RecipePreview>? recipePreviews;

  static Message fromJson(Map jsonData) {
    return Message(
      jsonData["id"],
      jsonData["senderId"],
      jsonData["senderName"],
      (jsonData["seenByUserIds"] as List).map((id) => id as String).toList(),
      jsonData["sentData"] != null ? DateTime.parse(jsonData["sentData"]) : null,
      jsonData["updatedDate"] != null ? DateTime.parse(jsonData["updatedDate"]) : null,
      jsonData["repliedToMessageId"],
      jsonData["textContent"],
      (jsonData["imageURLs"] as List<String>?)?.map((url) => url).toList(),
      jsonData["recipePreviews"]?.map<RecipePreview>((r) => RecipePreview.fromJson(r)).toList()
    );
  }

  @override
  List<Object?> get props => [
    id, senderId, sentDate, updatedDate,
    repliedToMessageId, textContent, imageURLs,
    recipePreviews, senderName
  ];
}