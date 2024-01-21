part of 'conversation_entities.dart';

class Message extends Equatable {
  const Message({
    required this.id,
    required this.senderId,
    this.sentDate,
    this.updatedDate,
    this.repliedToMessageId,
    this.textContent,
    this.imageURLs,
    this.recipeIds
  });

  final String id;
  final String senderId;
  final DateTime? sentDate;
  final DateTime? updatedDate;
  final String? repliedToMessageId;
  final String? textContent;
  final List<String>? imageURLs;
  final List<String>? recipeIds;

  @override
  List<Object?> get props => [
    id, senderId, sentDate, updatedDate,
    repliedToMessageId, textContent, imageURLs,
    recipeIds
  ];
}