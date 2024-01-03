import 'package:flutter/material.dart';
import 'package:recipe_social_media/entities/messaging/conversation_details.dart';
import 'package:recipe_social_media/pages/conversation/widgets/conversation_back_button.dart';

class ConversationTopBar extends StatelessWidget {
  const ConversationTopBar({super.key, required this.details});

  static const double conversationIconSize = 25;
  final ConversationDetails details;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF02A713),
      title: Row(
        children: [
          CircleAvatar(
              backgroundColor: const Color.fromRGBO(106, 113, 117, 1),
              child: Icon(
                details.isGroup ? Icons.group : Icons.person,
                color: const Color.fromRGBO(207, 212, 214, 1),
                size: conversationIconSize,
              )
          ),
          const SizedBox(width: 8),
          Text(details.conversationName, style: const TextStyle(color: Colors.white)),
        ],
      ),
      leading: const ConversationBackButton(),
      actions: <Widget>[
        Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: const Icon(
                  Icons.search,
                  size: 26.0,
                  color: Colors.white
              ),
            )
        ),
        Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: const Icon(
                  Icons.more_vert,
                  color: Colors.white),
            )
        ),
      ],
    );
  }
}