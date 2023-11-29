import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recipe_social_media/entities/messaging/conversation_card_content.dart';

class ConversationCard extends StatelessWidget {

  static const double conversationImageSize = 50;
  static const double statusImageSize = 20;
  static const double pinIconSize = 30;

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
                      ClipOval(
                        child: Container(
                          constraints: const BoxConstraints(
                            maxHeight: conversationImageSize,
                            maxWidth: conversationImageSize
                          ),
                          child: conversationCardContent.conversationImage,
                          )
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          constraints: const BoxConstraints(
                            maxHeight: statusImageSize,
                            maxWidth: statusImageSize
                          ),
                          child: getStatusIcon(conversationCardContent.conversationStatus),
                        )
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
                            ? Transform.rotate(angle: pi / 4, child: const Icon(Icons.push_pin, size: pinIconSize))
                            : const SizedBox (width: pinIconSize, height: pinIconSize)
                      ]
                  )
              ),
            ],
          ),
        )
    );
  }

  Widget getStatusIcon(ConversationStatus conversationStatus) {
    switch (conversationStatus) {
      case ConversationStatus.blocked:
        return Image.asset("assets/images/block_icon.png");
      case ConversationStatus.pending:
        return Image.asset("assets/images/pending_icon.png");

      default:
        return const SizedBox.shrink();
    }
  }
}