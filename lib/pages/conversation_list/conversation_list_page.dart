import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_social_media/pages/conversation_list/bloc/conversation_list_bloc.dart';
import 'package:recipe_social_media/pages/conversation_list/widgets/conversation_list.dart';
import 'package:recipe_social_media/pages/conversation_list/widgets/conversation_sortby_section.dart';
import 'package:recipe_social_media/utilities/utilities.dart';
import 'package:recipe_social_media/widgets/shared_widgets.dart';

class ConversationListPage extends StatelessWidget implements PageLander  {
  const ConversationListPage({super.key});

  @override
  void onLanding(BuildContext context) {
    BlocProvider.of<ConversationListBloc>(context)
     .add(const ChangeConversationsToDisplay());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomSearchAppBar(
        title: const Text("Conversations"),
        onSearchFunc: (term) {print(term);},
        actions: [
          IconButton(
          icon: const Icon(Icons.more_vert_rounded),
          onPressed: () {print("more options pressed");})
        ],
      ),
      floatingActionButton: CustomFloatingButton(
        key: const Key("conversationListPage"),
        icon: Icons.add,
        eventFunc: () {print("float button pressed");}
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: BlocBuilder<ConversationListBloc, ConversationListState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConversationSortBySection(selectedSortingOption: state.selectedSortingOption),
              state.conversationCards.isNotEmpty
                ? const ConversationList()
                : Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: Center(
                      child: Text("You have no conversations yet!",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground, fontSize: 20
                        ),
                      )
                    )
                )
            ]
          );
        }
      )
    );
  }
}