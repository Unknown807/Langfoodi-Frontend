import 'package:flutter/material.dart';
import 'package:recipe_social_media/utilities/utilities.dart';

import '../../widgets/new_conversation_floating_button.dart';
import '../../widgets/sorting_options_button.dart';

class ConversationListPage extends StatefulWidget implements PageLander
{
  const ConversationListPage({super.key});

  @override
  State<ConversationListPage> createState() => _ConversationListPageState();

  @override
  void onLanding(BuildContext context) {
    
  }
}

class _ConversationListPageState extends State<ConversationListPage> {
  final int numberOfConversations = 10;
  final Widget conversationDivider = const Divider(height:1, color: Color(0xFFeaeaea));

  SortingOption selectedSortingOption = SortingOption.lastMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getSortBySection(),
          getConversationList()
        ]
      ),
      floatingActionButton: const NewConversationFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget getConversationList() {
    return Expanded(
        child:
        ListView.separated(
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
            itemCount: 2 + numberOfConversations
        )
    );
  }

  Widget getSortBySection() {
    return Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 10),
        color: const Color(0xFF02A713),
        child: Row(
            children: [
              const Text("Sort By:", style: TextStyle(color: Colors.white, fontSize: 16)),
              const SizedBox(width: 18),
              SortingOptionButton(
                  isSelected: selectedSortingOption == SortingOption.lastMessage,
                  sortingOption: SortingOption.lastMessage,
                  onPressed: ()
                  {
                    setState(() {
                      selectedSortingOption = SortingOption.lastMessage;
                    });
                  }
              ),
              const SizedBox(width: 18),
              SortingOptionButton(
                  isSelected: selectedSortingOption == SortingOption.alphabeticalOrder,
                  sortingOption: SortingOption.alphabeticalOrder,
                  onPressed: ()
                  {
                    setState(() {
                      selectedSortingOption = SortingOption.alphabeticalOrder;
                    });
                  }
              ),
              const SizedBox(width: 18),
              SortingOptionButton(
                  isSelected: selectedSortingOption == SortingOption.dateAdded,
                  sortingOption: SortingOption.dateAdded,
                  onPressed: ()
                  {
                    setState(() {
                      selectedSortingOption = SortingOption.dateAdded;
                    });
                  }
              )
            ]
        )
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
