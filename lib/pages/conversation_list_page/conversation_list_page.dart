import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_social_media/pages/conversation_list_page/bloc/conversation_list_bloc.dart';
import 'package:recipe_social_media/utilities/utilities.dart';
import 'package:recipe_social_media/pages/conversation_list_page/widgets/conversation_card.dart';
import 'package:recipe_social_media/widgets/plus_floating_button.dart';
import 'package:recipe_social_media/widgets/sorting_options_button.dart';

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
        create: (conversationListContext) => ConversationListBloc()
          ..add(const InitState()),
        child: BlocConsumer<ConversationListBloc, ConversationListState>(
            listener: (BuildContext context, ConversationListState state) { },
            builder: (context, state) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getSortBySection(context, state),
                    state.conversationCards.isNotEmpty
                        ? getConversationList(state)
                        : Container(
                        padding: const EdgeInsets.only(top: 20),
                        child: const Center(
                          child: Text("You have no conversations yet!", style: TextStyle(fontSize: 20),),
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

  Widget getConversationList(ConversationListState state) {
    return Expanded(
        child:
        ListView.separated(
            itemBuilder: (context, index) {
              bool isAtListEnd = index == 0 || index == state.conversationCards.length + 1;
              if (isAtListEnd) {
                return const SizedBox.shrink();
              }
              return ConversationCard(conversationCardContent: state.conversationCards[index - 1]);
            },
            separatorBuilder: (context, index) {
              return state.conversationDivider;
            },
            itemCount: 2 + state.conversationCards.length
        )
    );
  }

  Widget getSortBySection(BuildContext context, ConversationListState state) {
    return Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 10),
        color: const Color(0xFF02A713),
        child: Row(
            children: [
              Flexible(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: [
                            const Text("Sort By:", style: TextStyle(
                                color: Colors.white, fontSize: 16)),
                            const SizedBox(width: 18),
                            SortingOptionButton(
                                isSelected: state.selectedSortingOption ==
                                    SortingOption.lastMessage,
                                sortingOption: SortingOption.lastMessage,
                                onPressed: () {
                                  context
                                    .read<ConversationListBloc>()
                                    .add(const ChangeSelectedSortingOption(SortingOption.lastMessage));
                                }
                            ),
                            const SizedBox(width: 18),
                            SortingOptionButton(
                                isSelected: state.selectedSortingOption ==
                                    SortingOption.alphabeticalOrder,
                                sortingOption: SortingOption.alphabeticalOrder,
                                onPressed: () {
                                  context
                                    .read<ConversationListBloc>()
                                    .add(const ChangeSelectedSortingOption(SortingOption.alphabeticalOrder));
                                }
                            ),
                            const SizedBox(width: 18),
                            SortingOptionButton(
                                isSelected: state.selectedSortingOption ==
                                    SortingOption.dateAdded,
                                sortingOption: SortingOption.dateAdded,
                                onPressed: () {
                                  context
                                    .read<ConversationListBloc>()
                                    .add(const ChangeSelectedSortingOption(SortingOption.dateAdded));
                                }
                            )
                          ]
                      )
                  )
              )
            ]
        )
    );
  }
}