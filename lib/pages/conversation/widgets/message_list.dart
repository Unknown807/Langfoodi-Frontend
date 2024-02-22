part of 'conversation_widgets.dart';

class MessageList extends StatelessWidget {
  const MessageList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConversationBloc, ConversationState>(
      listener: (context, state) {
        if (state.dialogMessage.isNotEmpty) {
          showDialog(
            context: context,
            builder: (_) => BlocProvider<ConversationBloc>.value(
              value: BlocProvider.of<ConversationBloc>(context),
              child: CustomAlertDialog(
                title: Text(state.dialogTitle),
                content: Text(state.dialogMessage),
                leftButtonText: null,
                rightButtonCallback: () => context
                  .read<ConversationBloc>()
                  .add(const ResetPopupDialog())
              )
            )
          );
        }
      },
      builder: (context, state) {
        return state.pageLoading
          ? const Center(child: CircularProgressIndicator())
          : state.messages.isEmpty
            ? Container(
                padding: const EdgeInsets.all(20),
                child: Text("No Messages Yet!",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground.withAlpha(180),
                    fontSize: 18
                  ),
                )
              )
            : StickyGroupedListView<Message, DateTime>(
                itemScrollController: state.messageListScrollController,
                padding: const EdgeInsets.all(8),
                reverse: true,
                order: StickyGroupedListOrder.DESC,
                floatingHeader: true,
                elements: state.messages,
                itemComparator: (m1, m2) => m1.sentDate!.compareTo(m2.sentDate!),
                groupBy: (message) => DateTime(
                  message.sentDate!.year,
                  message.sentDate!.month,
                  message.sentDate!.day
                ),
                groupSeparatorBuilder: (message) => SizedBox(
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
                  bool isSentByMe = message.userPreview.id == state.senderId;
                  return Column(
                    children: <Widget>[
                      if (isSentByMe)
                        SwipePlus(
                          minThreshold: .5,
                          onDragComplete: () => context
                            .read<ConversationBloc>()
                            .add(ReplyToMessage(message)),
                          child: RemoveMessageContextMenu(
                            messageId: message.id,
                            child: Bubble(
                              nipWidth: 3,
                              elevation: 5,
                              margin: BubbleEdges.only(
                                left: MediaQuery.of(context).size.width*0.25,
                                top: 10,
                              ),
                              padding: const BubbleEdges.all(12),
                              color: Theme.of(context).colorScheme.primary.withGreen(190),
                              nip: BubbleNip.rightTop,
                              alignment: Alignment.centerRight,
                              child: ChatBubbleContent(
                                userIds: state.userIds,
                                isGroup: state.isGroup,
                                isSentByMe: isSentByMe,
                                message: message,
                                repliedMessage: state.messages
                                  .cast<Message?>()
                                  .firstWhere(
                                    (msg) => msg!.id == message.repliedToMessageId,
                                    orElse: () => null)
                              )
                            )
                          )
                        ),
                      if (!isSentByMe)
                        SwipePlus(
                          minThreshold: .5,
                          onDragComplete: () => context
                            .read<ConversationBloc>()
                            .add(ReplyToMessage(message)),
                          child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (state.isGroup)
                              message.userPreview.profileImageId != null
                                ? SizedBox(
                                    height: 26,
                                    width: 26,
                                    child: ClipOval(
                                      child: context.read<ImageBuilder>().displayCloudinaryImage(
                                        imageUrl: message.userPreview.profileImageId!,
                                        transformationType: ImageTransformationType.tiny,
                                        errorBuilder: (err, ob1, ob2) {
                                          return CustomIconTile(
                                            padding: EdgeInsets.zero,
                                            icon: Icons.error,
                                            borderStrokeWidth: 4,
                                            iconSize: 20,
                                            borderRadius: 20,
                                            iconColor: Theme.of(context).colorScheme.error,
                                            tileColor: Theme.of(context).colorScheme.error,
                                          );
                                        }
                                      ),
                                    ),
                                  )
                              : const CustomCircleAvatar(
                                  avatarIcon: Icons.person,
                                  avatarIconSize: 16,
                                  circleRadiusSize: 13
                                ),
                            Flexible(child: Bubble(
                              nipWidth: 3,
                              elevation: 5,
                              margin: BubbleEdges.only(
                                right: MediaQuery.of(context).size.width*0.20,
                                top: 10,
                                left: 5,
                              ),
                              padding: const BubbleEdges.all(12),
                              color: Theme.of(context).colorScheme.secondary.withRed(235),
                              nip: BubbleNip.leftTop,
                              child: ChatBubbleContent(
                                userIds: state.userIds,
                                isGroup: state.isGroup,
                                nameColour: state.nameColours[message.userPreview.id],
                                isSentByMe: isSentByMe,
                                message: message,
                                repliedMessage: state.messages
                                  .cast<Message?>()
                                  .firstWhere(
                                    (msg) => msg!.id == message.repliedToMessageId,
                                    orElse: () => null)
                              ),
                            )),
                          ]
                        )),
                      if (state.messages.last.id == message.id)
                        const SentMessageProgressIndicator()
                    ],
                  );
                },
          );
      },
    );
  }
}