part of 'conversation_widgets.dart';

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
              ? Bubble(
                  nipWidth: 3,
                  elevation: 5,
                  margin: BubbleEdges.only(
                    left: MediaQuery.of(context).size.width*0.25,
                    top: 10,
                  ),
                  padding: const BubbleEdges.all(12),
                  color: Theme.of(context).colorScheme.primary,
                  nip: BubbleNip.rightTop,
                  alignment: Alignment.centerRight,
                  child: ChatBubbleContent(
                    isSentByMe: isSentByMe,
                    message: message,
                  )
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state.isGroup)
                      const CustomCircleAvatar(
                        avatarIcon: Icons.person,
                        avatarIconSize: 16,
                        circleRadiusSize: 13
                      ),
                    Flexible(child: Bubble(
                      nipWidth: 3,
                      elevation: 5,
                      margin: BubbleEdges.only(
                        right: MediaQuery.of(context).size.width*0.25,
                        top: 10,
                        left: 5,
                      ),
                      padding: const BubbleEdges.all(12),
                      color: Theme.of(context).colorScheme.secondary.withRed(240),
                      nip: BubbleNip.leftTop,
                      child: ChatBubbleContent(
                        nameColour: state.nameColours[message.senderId],
                        isSentByMe: isSentByMe,
                        message: message),
                    )),
                  ]
                );
          },
        );
      },
    );
  }
}