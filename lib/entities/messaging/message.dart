import 'package:equatable/equatable.dart';
import 'package:recipe_social_media/entities/user/user_entities.dart';

class Message extends Equatable {
  const Message({
    required this.text,
    required this.sender,
    required this.dateSent
  });

  final String text;
  final UserAccount sender;
  final DateTime dateSent;

  @override
  List<Object?> get props => [];

}