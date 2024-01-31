import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_social_media/pages/conversation_list/bloc/conversation_list_bloc.dart';
import 'package:recipe_social_media/widgets/shared_widgets.dart';

class ConversationSortBySection extends StatelessWidget {
  const ConversationSortBySection({super.key, required this.selectedSortingOption});

  final SortingOption selectedSortingOption;

  @override
  Widget build(BuildContext context) {
    return Container (
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
                                isSelected: selectedSortingOption ==
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
                                isSelected: selectedSortingOption ==
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
                                isSelected: selectedSortingOption ==
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