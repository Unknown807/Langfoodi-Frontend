part of 'conversation_widgets.dart';

class MessageReplyBox extends StatelessWidget {
  const MessageReplyBox({
    super.key,
    required this.message,
    this.replying = false,
    this.isSentByMe = false
  });

  final Message message;
  final bool replying;
  final bool isSentByMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: replying ? const EdgeInsets.fromLTRB(8, 5, 6, 0) : EdgeInsets.zero,
        child: GestureDetector(
          onTap: () => context.read<ConversationBloc>().add(ScrollToMessage(message.id)),
          child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 4),
              padding: const EdgeInsets.fromLTRB(6, 4, 8, 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Theme.of(context).colorScheme.background.withAlpha(150),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(isSentByMe ? "You" : message.senderName,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground.withAlpha(180),
                          fontWeight: FontWeight.bold,
                          fontSize: 14
                        )
                      ),

                      if (message.textContent != null)
                        Text(
                          "${message.textContent!.length >= 20
                            ? message.textContent!.substring(0, 20)
                            : message.textContent!}...",
                          style: TextStyle(color: Theme.of(context).colorScheme.onBackground.withAlpha(180)),
                        ),

                      if (message.recipes != null)
                        const ReplyBoxAttachment(icon: Icons.fastfood_rounded, text: " Recipes"),

                      if (message.imageURLs != null)
                        const ReplyBoxAttachment(icon: Icons.image_rounded, text: " Images"),
                    ],
                  ),
                const Spacer(),
                if (replying)
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    splashRadius: 10,
                    icon: Icon(
                      Icons.close_rounded,
                      color: Theme.of(context).colorScheme.inversePrimary,
                      size: 18,
                    ),
                    onPressed: () => context
                      .read<ConversationBloc>()
                      .add(const ReplyToMessage(null))
                  )
              ])),
        ));
  }
}
