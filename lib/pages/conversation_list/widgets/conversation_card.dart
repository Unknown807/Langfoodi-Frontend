part of 'conversation_list_widgets.dart';

class ConversationCard extends StatelessWidget {
  const ConversationCard({
    super.key,
    required this.conversation
  });

  static const double conversationIconSize = 30;
  static const double statusIconSize = 20;
  static const double pinIconSize = 15;

  final Conversation conversation;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationListBloc, ConversationListState>(
      builder: (context, state) {
        final isPinned = state.pinnedIds.contains(conversation.id);
        return GestureDetector(
          onTap: () => context
            .read<NavigationRepository>()
            .goTo(context, "/conversation",
            arguments: ConversationPageArguments(conversation: conversation)),
          child: PinConversationContextMenu(
            isPinned: isPinned,
            conversationId: conversation.id,
            child: Center(
              child: Card(
                color: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
                child: ListTile(
                  leading: conversation.thumbnailId != null
                    ? SizedBox(
                        height: 42,
                        width: 42,
                        child: ClipOval(
                          child: context.read<ImageBuilder>().displayCloudinaryImage(
                            imageUrl: conversation.thumbnailId!,
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
                    : CustomCircleAvatar(
                        avatarIcon: conversation.isGroup ? Icons.group : Icons.person,
                      ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(
                          conversation.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: 18, fontWeight: FontWeight.bold),
                        )
                      ),
                      Text(
                        conversation.lastMessage?.sentDate != null
                          ? DateFormat("dd/MM/yyyy").format(conversation.lastMessage!.sentDate!)
                          : "",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 12)
                      )
                    ]
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(
                          conversation.lastMessage != null && conversation.lastMessage!.userPreview.username.isNotEmpty
                            ? "${conversation.lastMessage!.userPreview.username}: ${conversation.lastMessage!.textContent ?? "..."}"
                            : "",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            color: Theme.of(context).hintColor,
                            fontSize: 16
                          ),
                      )),

                      if (conversation.messagesUnseen > 0)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 2, 8, 0),
                          child: ClipOval(
                            child: Container(
                              color: Theme.of(context).colorScheme.primary,
                              width: 25,
                              height: 25,
                              child: Center(
                                child: Text(
                                  "${conversation.messagesUnseen}",
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.onPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                )),
                            ),
                          ),
                        ),

                      Transform.rotate(
                        angle: pi / 4,
                        child: Icon(
                          Icons.push_pin,
                          size: pinIconSize,
                          color: isPinned
                            ? Theme.of(context).colorScheme.onBackground.withAlpha(180)
                            : Theme.of(context).scaffoldBackgroundColor
                        )
                      ),
                    ]
                  )
              ),
            )
          )
        ));
      }
    );
  }
}