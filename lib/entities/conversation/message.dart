part of 'conversation_entities.dart';

class Message extends Equatable {
  const Message({
    required this.id,
    required this.senderId,
    required this.senderName,
    this.sentDate,
    this.updatedDate,
    this.repliedToMessageId,
    this.textContent,
    this.imageURLs,
    this.recipePreviews
  });

  final String id;
  final String senderId;
  final String senderName;
  final DateTime? sentDate;
  final DateTime? updatedDate;
  final String? repliedToMessageId;
  final String? textContent;
  final List<String>? imageURLs;
  final List<RecipePreview>? recipePreviews;

  @override
  List<Object?> get props => [
    id, senderId, sentDate, updatedDate,
    repliedToMessageId, textContent, imageURLs,
    recipePreviews, senderName
  ];
}