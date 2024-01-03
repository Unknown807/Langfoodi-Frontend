import 'package:flutter/material.dart';
import 'package:recipe_social_media/entities/messaging/conversation_details.dart';
import 'package:recipe_social_media/pages/conversation/widgets/conversation_top_bar.dart';

class ConversationPage extends StatelessWidget {
  const ConversationPage({super.key});

  @override
  Widget build(BuildContext context) {

    var conversationDetails = ModalRoute.of(context)!.settings.arguments as ConversationDetails;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: ConversationTopBar(details: conversationDetails)
      ),
      body: const Column (
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

          ]
      )
    );
  }
}