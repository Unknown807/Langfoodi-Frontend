import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_social_media/pages/conversation_list_page/bloc/conversation_list_bloc.dart';
import 'package:recipe_social_media/pages/conversation_list_page/widgets/conversation_card.dart';

class ConversationList extends StatelessWidget {
  const ConversationList({super.key});

  final Widget conversationDivider = const Divider(height:1, color: Color(0xFFeaeaea));

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationListBloc, ConversationListState> (builder: (BuildContext context, state) {
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
                return conversationDivider;
              },
              itemCount: 2 + state.conversationCards.length
          )
      );
    });
  }
}