import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_social_media/pages/conversation_list/bloc/conversation_list_bloc.dart';
import 'package:recipe_social_media/pages/conversation_list/widgets/conversation_card.dart';

class ConversationList extends StatelessWidget {
  const ConversationList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationListBloc, ConversationListState>(
      buildWhen: (p, c) =>
        p.conversations != c.conversations
        || p.shownConversations != c.shownConversations,
      builder: (BuildContext context, state) {
        return Expanded(
          child: ListView.builder(
            itemCount: state.conversations.length ,
            itemBuilder: (context, index) {
              bool show = state.shownConversations[index];
              return Column(
                children: <Widget>[
                  if (show) ConversationCard(conversation: state.conversations[index]),
                  if (show) Divider(height:1, color: Theme.of(context).hintColor.withAlpha(40))
                ],
              );
            },
          )
        );
    });
  }
}