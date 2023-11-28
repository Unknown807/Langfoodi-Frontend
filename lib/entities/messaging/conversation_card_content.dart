import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ConversationCardContent extends Equatable {

  final String conversationName;
  final ConversationStatus conversationStatus;
  final String lastMessage;
  final String lastMessageSender;
  final DateTime? lastMessageSentDate;
  final bool isPinned;
  final IconData conversationImage;

  const ConversationCardContent({
    required this.conversationName,
    required this.conversationStatus,
    this.lastMessage = "",
    this.lastMessageSender = "",
    this.lastMessageSentDate,
    required this.isPinned,
    this.conversationImage = Icons.person});

  @override
  List<Object?> get props => [conversationName, conversationStatus, lastMessage, lastMessageSender, lastMessageSentDate, isPinned];
}

enum ConversationStatus { connected, blocked, pending }