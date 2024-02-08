part of 'package:recipe_social_media/pages/conversation/widgets/conversation_widgets.dart';

class ChatBubbleReplyBox extends StatelessWidget {
  const ChatBubbleReplyBox({
    super.key,
    required this.message
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Theme.of(context).colorScheme.background.withAlpha(150),
        border: Border.all(color: Theme.of(context).colorScheme.tertiary)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (message.textContent != null)
            Text(
              "${message.textContent!.substring(0, 20)}...",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground.withAlpha(150)
              ),
            ),

          Row(
            children: <Widget>[
              Icon(Icons.image_rounded),
              Text(" Image")
            ],
          )
        ],
      )
    );
  }
}