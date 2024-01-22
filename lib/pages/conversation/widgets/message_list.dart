import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:recipe_social_media/pages/conversation/bloc/conversation_bloc.dart';
import 'package:recipe_social_media/widgets/shared_widgets.dart';

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
                  padding: const EdgeInsets.all(5),
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
            return isSentByMe
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomCircleAvatar(
                      avatarIcon: Icons.person,
                      avatarIconSize: 16,
                        circleRadiusSize: 13
                    ),
                    Flexible(child: Bubble(
                      nipWidth: 3,
                      elevation: 5,
                      margin: const BubbleEdges.only(left: 5, top: 10),
                      padding: const BubbleEdges.all(12),
                      color: Theme.of(context).colorScheme.secondary.withRed(240),
                      nip: BubbleNip.leftTop,
                      child: IntrinsicWidth(
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Username 1",
                            style: TextStyle(color: Theme.of(context).colorScheme.onSecondary)
                          ),
                          Flexible(child: Text(message.textContent ?? "",
                            style: TextStyle(color: Theme.of(context).colorScheme.onBackground)
                          )),
                          const SizedBox(height: 4),
                          IntrinsicHeight(
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text(DateFormat("HH:mm").format(message.sentDate!),
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onSecondary,
                                  fontSize: 11,
                                )
                              ),
                            )
                          )
                        ],
                      )),
                    )),
                  ]
                )
              : Bubble(
                  nipWidth: 3,
                  elevation: 5,
                  margin: const BubbleEdges.only(top: 10),
                  padding: const BubbleEdges.all(12),
                  color: Theme.of(context).colorScheme.primary,
                  nip: BubbleNip.rightTop,
                  alignment: Alignment.centerRight,
                  child: Text(
                    message.textContent ?? "",
                    style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                  )
                );
          },
        );
      },
    );
  }
}