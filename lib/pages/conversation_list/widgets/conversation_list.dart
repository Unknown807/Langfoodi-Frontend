import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_social_media/pages/conversation_list/bloc/conversation_list_bloc.dart';
import 'package:recipe_social_media/pages/conversation_list/widgets/conversation_card.dart';

class ConversationList extends StatelessWidget {
  const ConversationList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationListBloc, ConversationListState>(
      builder: (BuildContext context, state) {
        return Expanded(
          child: ListView.builder(
            itemCount: state.conversations.length ,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  ConversationCard(conversation: state.conversations[index]),
                  Divider(height:1, color: Theme.of(context).hintColor.withAlpha(40))
                ],
              );
            },
          )
        );
    });
  }
}