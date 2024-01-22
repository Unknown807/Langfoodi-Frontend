part of 'conversation_widgets.dart';

class ChatBubbleContent extends StatelessWidget {
  const ChatBubbleContent({
    super.key,
    required this.isSentByMe,
    required this.message
  });

  final bool isSentByMe;
  final Message message;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!isSentByMe)
            Text("Username 1",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary,
                fontWeight: FontWeight.bold,
                fontSize: 12
              )
            ),
          Flexible(child: Text(message.textContent ?? "",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 15
            )
          )),
          const SizedBox(height: 4),
          IntrinsicHeight(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(DateFormat("HH:mm").format(message.sentDate!),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontSize: 10,
                    )
                ),
              )
          )
        ],
      ));
  }
}