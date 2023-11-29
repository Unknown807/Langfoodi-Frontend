import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ConversationCardContent extends Equatable {

  final String conversationName;
  final ConversationStatus conversationStatus;
  final String lastMessage;
  final String lastMessageSender;
  final DateTime? lastMessageSentDate;
  final bool isPinned;
  final Image conversationImage;
  final bool isGroup;

  const ConversationCardContent({
    required this.conversationName,
    required this.conversationStatus,
    this.lastMessage = "",
    this.lastMessageSender = "",
    this.lastMessageSentDate,
    required this.isPinned,
    required this.isGroup,
    required this.conversationImage
  });

factory ConversationCardContent.withDefaultImage({
  required String conversationName,
  required ConversationStatus conversationStatus,
  String lastMessage = "",
  String lastMessageSender = "",
  DateTime? lastMessageSentDate,
  required bool isPinned,
  required bool isGroup,
  }) {
    return ConversationCardContent(
      conversationName: conversationName,
      conversationStatus: conversationStatus,
      lastMessage: lastMessage,
      lastMessageSender: lastMessageSender,
      lastMessageSentDate: lastMessageSentDate,
      isPinned: isPinned,
      isGroup: isGroup,
      conversationImage: isGroup ? Image.asset("assets/images/group_icon.png", fit: BoxFit.cover) : Image.asset("assets/images/connection_icon.png", fit: BoxFit.cover),
    );
  }


@override
  List<Object?> get props => [conversationName, conversationStatus, lastMessage, lastMessageSender, lastMessageSentDate, isPinned, conversationImage];
}

enum ConversationStatus { connected, blocked, pending }