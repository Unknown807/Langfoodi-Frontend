import 'package:flutter/material.dart';
import 'package:recipe_social_media/entities/messaging/conversation_details.dart';
import 'package:recipe_social_media/widgets/shared_widgets.dart';

class ConversationPage extends StatelessWidget {
  const ConversationPage({super.key});

  @override
  Widget build(BuildContext context) {
    var convoDetails = ModalRoute.of(context)!.settings.arguments as ConversationDetails;

    return Scaffold(
      appBar: CustomSearchAppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color.fromRGBO(106, 113, 117, 1),
              child: Icon(
                convoDetails.isGroup ? Icons.group : Icons.person,
                color: const Color.fromRGBO(207, 212, 214, 1),
                size: 25,
              )
            ),
            const SizedBox(width: 10),
            Text(convoDetails.conversationName,
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert_rounded),
            onPressed: () {print("more options pressed");},
          )
        ],
        onSearchFunc: (term) {print(term);},
      ),
      body: const Column (
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        ]
      )
    );
  }
}