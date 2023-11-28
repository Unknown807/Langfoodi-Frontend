import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recipe_social_media/utilities/utilities.dart';

import '../../entities/messaging/conversation_card_content.dart';
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
  List<ConversationCardContent> conversationCards = [
    ConversationCardContent(conversationName: "Connection1", conversationStatus: ConversationStatus.connected, lastMessage: "Last message...", lastMessageSender: "You", lastMessageSentDate: DateTime(2023, 11, 18), isPinned: true),
    ConversationCardContent(conversationName: "Connection2", conversationStatus: ConversationStatus.connected, lastMessage: "Last message sent...", lastMessageSender: "Connection2", lastMessageSentDate: DateTime(2023, 11, 13), isPinned: true),
    ConversationCardContent(conversationName: "Group1", conversationImage: Icons.group,  conversationStatus: ConversationStatus.connected, lastMessage: "Last message...", lastMessageSender: "GroupMember1", lastMessageSentDate: DateTime(2023, 11, 25), isPinned: false),
    ConversationCardContent(conversationName: "Group2", conversationImage: Icons.group, conversationStatus: ConversationStatus.connected, isPinned: false),
    ConversationCardContent(conversationName: "Connection3", conversationStatus: ConversationStatus.pending, lastMessage: "Last message...", lastMessageSender: "Connection3", lastMessageSentDate: DateTime(2023, 11, 12), isPinned: false),
    ConversationCardContent(conversationName: "Connection4", conversationStatus: ConversationStatus.blocked, isPinned: false),
    ConversationCardContent(conversationName: "Group3", conversationImage: Icons.group, conversationStatus: ConversationStatus.connected, lastMessage: "Last message sent...", lastMessageSender: "You", lastMessageSentDate: DateTime(2023, 01, 19), isPinned: false),
    ConversationCardContent(conversationName: "Connection5", conversationStatus: ConversationStatus.blocked, isPinned: false)
  ];

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
              bool isAtListEnd = index == 0 || index == conversationCards.length + 1;
              if (isAtListEnd) {
                return const SizedBox.shrink();
              }
              return buildConversationCard(conversationCards[index - 1]);
            },
            separatorBuilder: (context, index) {
              return conversationDivider;
            },
            itemCount: 2 + conversationCards.length
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

  Widget buildConversationCard(ConversationCardContent conversationCardContent) => Center(
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