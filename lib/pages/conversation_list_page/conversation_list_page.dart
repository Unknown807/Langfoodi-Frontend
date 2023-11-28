import 'package:flutter/material.dart';
import 'package:recipe_social_media/utilities/utilities.dart';

class ConversationListPage extends StatelessWidget implements PageLander
{
  const ConversationListPage({super.key});

  final int numberOfConversations = 10;
  final Widget conversationDivider = const Divider(height:1, color: Color(0xFFeaeaea));

  @override
  void onLanding(BuildContext context) {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: ListView.separated(
          itemBuilder: (context, index) {
            bool isAtListEnd = index == 0 || index == numberOfConversations + 1;
            if (isAtListEnd) {
              return const SizedBox.shrink();
            }
            return buildConversationCard(index);
          },
          separatorBuilder: (context, index) {
            return conversationDivider;
          },
          itemCount: 2 + numberOfConversations),
      floatingActionButton: const NewConversationFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget buildConversationCard(int index) => Center(
    child: Card(
      shape: const ContinuousRectangleBorder(borderRadius: BorderRadius.zero),
      elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.person, size: 50),
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Conversation $index", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const Text("28/11/2023", style: TextStyle(fontSize: 12))
                ]
            ),
            subtitle: const Text("Last message...", style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    )
  );
}

class NewConversationFloatingButton extends StatelessWidget{
  const NewConversationFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.large(
      onPressed: () {

      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100.0), // Adjust the radius
      ),
      backgroundColor: const Color(0xFF189A03),
      child: const Icon(
        Icons.add,
        color: Colors.white,
        size: 80
      )
    );
  }
}