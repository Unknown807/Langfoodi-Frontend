part of 'package:recipe_social_media/pages/conversation/widgets/conversation_widgets.dart';

class ChatBubbleReplyBox extends StatelessWidget {
  const ChatBubbleReplyBox({
    super.key,
    required this.message
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context
        .read<ConversationBloc>()
        .add(ScrollToMessage(message.id)),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Theme.of(context).colorScheme.background.withAlpha(150),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (message.textContent != null)
              Text(
                "${message.textContent!.length >= 20
                  ? message.textContent!.substring(0, 20)
                  : message.textContent!}...",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground.withAlpha(180)
                ),
              ),

            if (message.recipes != null)
              const ReplyBoxAttachment(icon: Icons.fastfood_rounded, text: " Recipes"),

            if (message.imageURLs != null)
              const ReplyBoxAttachment(icon: Icons.image_rounded, text: " Images"),
          ],
        )
      ),
    );
  }
}