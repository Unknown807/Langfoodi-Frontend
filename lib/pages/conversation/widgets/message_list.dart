import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:recipe_social_media/pages/conversation/bloc/conversation_bloc.dart';

class MessageList extends StatelessWidget {
  const MessageList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationBloc, ConversationState>(
      builder: (context, state) {
        return GroupedListView(
          padding: const EdgeInsets.all(8),
          reverse: true,
          order: GroupedListOrder.DESC,
          useStickyGroupSeparators: true,
          floatingHeader: true,
          elements: state.messages,
          groupBy: (message) => DateTime(
            message.sentDate!.year,
            message.sentDate!.month,
            message.sentDate!.day
          ),
          groupHeaderBuilder: (message) => SizedBox(
            height: 40,
            child: Center(
              child: Card(
                color: Theme.of(context).colorScheme.tertiary.withBlue(200),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    DateFormat.yMMMd().format(message.sentDate!),
                    style: TextStyle(
                      fontSize: 11,
                      color: Theme.of(context).colorScheme.onTertiary
                    )
                  ),
                ),
              ),
            ),
          ),
          itemBuilder: (context, message) {
            bool isSentByMe = message.senderId == state.senderId;
            return Bubble(
              elevation: 5,
              margin: const BubbleEdges.only(top: 10),
              padding: const BubbleEdges.all(12),
              color: isSentByMe
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary.withRed(245),
              nip: isSentByMe
                ? BubbleNip.rightTop
                : BubbleNip.leftTop,
              alignment: isSentByMe
                ? Alignment.centerRight
                : Alignment.centerLeft,
              child: Text(
                message.textContent ?? "no text",
                style: TextStyle(color: isSentByMe
                  ? Theme.of(context).colorScheme.onBackground
                  : Theme.of(context).colorScheme.onBackground
                ),
              )
            );
          },
        );
      },
    );
  }
}