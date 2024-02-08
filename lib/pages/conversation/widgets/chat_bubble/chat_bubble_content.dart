part of 'package:recipe_social_media/pages/conversation/widgets/conversation_widgets.dart';

class ChatBubbleContent extends StatelessWidget {
  const ChatBubbleContent({
    super.key,
    required this.isSentByMe,
    required this.message,
    this.repliedMessage,
    this.nameColour
  });

  final bool isSentByMe;
  final Message message;
  final Message? repliedMessage;
  final Color? nameColour;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (repliedMessage != null)
            Text(repliedMessage!.textContent ?? "..."),
          if (!isSentByMe)
            Text(message.senderName,
              style: TextStyle(
                color: nameColour,
                fontWeight: FontWeight.bold,
                fontSize: 12
              )
            ),
          if (!isSentByMe) const SizedBox(height: 4),
          if (message.imageURLs != null) ChatBubbleImageCarousel(imageUrls: message.imageURLs!),
          if (message.recipePreviews != null) ChatBubbleRecipeCarousel(recipePreviews: message.recipePreviews!),
          if (message.imageURLs != null || message.recipePreviews != null) const SizedBox(height: 4),
          Flexible(child: Text(message.textContent ?? "",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
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