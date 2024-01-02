import 'package:flutter/material.dart';
import 'package:recipe_social_media/pages/conversation/widgets/conversation_back_button.dart';

class ConversationTopBar extends StatelessWidget {
  const ConversationTopBar({super.key, required this.conversationName});

  final String conversationName;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF02A713),
      title: Text(conversationName, style: const TextStyle(color: Colors.white)),
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