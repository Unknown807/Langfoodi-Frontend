import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recipe_social_media/entities/messaging/conversation_card_content.dart';

class ConversationCard extends StatelessWidget {
  const ConversationCard({super.key, required this.conversationCardContent});

  final ConversationCardContent conversationCardContent;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
          shape: const ContinuousRectangleBorder(borderRadius: BorderRadius.zero),
          elevation: 0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                  leading: Stack(
                    children: [
                      Icon(conversationCardContent.conversationImage, size: 50),
                      Positioned(
                          top: 0,
                          left: 0,
                          child: getIcon(conversationCardContent.conversationStatus)
                      )
                    ],
                  ),
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(conversationCardContent.conversationName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text(
                            conversationCardContent.lastMessageSentDate != null
                                ? DateFormat("dd/MM/yyyy").format(conversationCardContent.lastMessageSentDate!)
                                : "",
                            style: const TextStyle(fontSize: 12))
                      ]
                  ),
                  subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                            conversationCardContent.lastMessage.isNotEmpty
                                ? "${conversationCardContent.lastMessageSender}: ${conversationCardContent.lastMessage}"
                                : "",
                            style: const TextStyle(fontSize: 16)
                        ),
                        conversationCardContent.isPinned
                            ? Transform.rotate(angle: pi / 4, child: const Icon(Icons.push_pin, size:30))
                            : const SizedBox (width: 30, height: 30)
                      ]
                  )
              ),
            ],
          ),
        )
    );
  }

  Widget getIcon(ConversationStatus conversationStatus) {
    switch (conversationStatus) {
      case ConversationStatus.blocked:
        return const Icon(Icons.block, size: 25, color: Colors.red);
      case ConversationStatus.pending:
        return const Icon(Icons.pending_actions, size: 25, color: Colors.blue);

      default:
        return const SizedBox.shrink();
    }
  }
}