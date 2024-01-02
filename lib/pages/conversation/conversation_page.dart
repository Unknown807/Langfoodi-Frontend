import 'package:flutter/material.dart';
import 'package:recipe_social_media/pages/conversation/widgets/conversation_top_bar.dart';

class ConversationPage extends StatelessWidget {
  const ConversationPage({super.key, required this.conversationName});

  final String conversationName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: ConversationTopBar(conversationName: conversationName)
      ),
      body: const Column (
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

          ]
      )
    );
  }
}