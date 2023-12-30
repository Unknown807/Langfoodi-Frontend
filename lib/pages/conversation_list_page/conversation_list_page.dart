import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_social_media/pages/conversation_list_page/bloc/conversation_list_bloc.dart';
import 'package:recipe_social_media/pages/conversation_list_page/widgets/conversation_list.dart';
import 'package:recipe_social_media/pages/conversation_list_page/widgets/conversation_sortby_section.dart';
import 'package:recipe_social_media/utilities/utilities.dart';
import 'package:recipe_social_media/widgets/plus_floating_button.dart';

class ConversationListPage extends StatelessWidget implements PageLander  {
  const ConversationListPage({super.key});

  @override
  void onLanding(BuildContext context) {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: BlocProvider<ConversationListBloc>(
          create: (conversationListContext) =>
          ConversationListBloc()
            ..add(const InitState()),
          child: BlocConsumer<ConversationListBloc, ConversationListState>(
              listener: (BuildContext context, ConversationListState state) {},
              builder: (context, state) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ConversationSortBySection(
                          selectedSortingOption: state.selectedSortingOption),
                      state.conversationCards.isNotEmpty
                          ? const ConversationList()
                          : Container(
                          padding: const EdgeInsets.only(top: 20),
                          child: const Center(
                            child: Text("You have no conversations yet!",
                              style: TextStyle(fontSize: 20),),
                          )
                      )
                    ]
                );
              }
          )
      ),
      floatingActionButton: const PlusFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}