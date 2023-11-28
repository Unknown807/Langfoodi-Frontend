import 'package:flutter/material.dart';
import 'package:recipe_social_media/utilities/utilities.dart';

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

  SortingOption selectedSortingOption = SortingOption.LastMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 10),
            color: const Color(0xFF02A713),
            child: Row(
              children: [
                const Text("Sort By:", style: TextStyle(color: Colors.white, fontSize: 16)),
                const SizedBox(width: 18),
                SortingOptionButton(
                  isSelected: selectedSortingOption == SortingOption.LastMessage,
                  sortingOption: SortingOption.LastMessage,
                    onPressed: ()
                    {
                      setState(() {
                        selectedSortingOption = SortingOption.LastMessage;
                      });
                    }
                ),
                const SizedBox(width: 18),
                SortingOptionButton(
                  isSelected: selectedSortingOption == SortingOption.AlphabeticalOrder,
                  sortingOption: SortingOption.AlphabeticalOrder,
                  onPressed: ()
                  {
                    setState(() {
                      selectedSortingOption = SortingOption.AlphabeticalOrder;
                    });
                  }
                ),
                const SizedBox(width: 18),
                SortingOptionButton(
                  isSelected: selectedSortingOption == SortingOption.DateAdded,
                  sortingOption: SortingOption.DateAdded,
                  onPressed: ()
                  {
                    setState(() {
                      selectedSortingOption = SortingOption.DateAdded;
                    });
                  }
                )
              ]
            )
          ),
          Expanded(
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
          )
        ]
      ),
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

class SortingOptionButton extends StatefulWidget{
  final bool isSelected;
  final SortingOption sortingOption;
  final VoidCallback? onPressed;

  const SortingOptionButton({super.key, required this.isSelected, required this.sortingOption, this.onPressed});

  @override
  State<SortingOptionButton> createState() => _SortingOptionButtonState();
}

class _SortingOptionButtonState extends State<SortingOptionButton> {

  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? const Color(0xFF09CE1C)
                : isHovered ? const Color(0xFF008E14) : const Color(0xFF05E15D),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            getSortingOptionDisplayText(widget.sortingOption),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      )
    );
  }

  String getSortingOptionDisplayText(SortingOption sortingOption) {
    switch (sortingOption) {
      case SortingOption.LastMessage:
        return 'Last message';
      case SortingOption.AlphabeticalOrder:
        return 'Alphabetical order';
      case SortingOption.DateAdded:
        return 'Date added';
    }
  }
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

enum SortingOption { LastMessage, AlphabeticalOrder, DateAdded }
