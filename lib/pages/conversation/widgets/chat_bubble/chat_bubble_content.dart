part of 'package:recipe_social_media/pages/conversation/widgets/conversation_widgets.dart';

class ChatBubbleContent extends StatelessWidget {
  const ChatBubbleContent({
    super.key,
    required this.isSentByMe,
    required this.isGroup,
    required this.message,
    required this.userIds,
    this.repliedMessage,
    this.nameColour
  });

  final bool isSentByMe;
  final bool isGroup;
  final Message message;
  final List<String> userIds;
  final Message? repliedMessage;
  final Color? nameColour;

  @override
  Widget build(BuildContext context) {
    bool readByAll = userIds.every((userId) => message.seenByUserIds.contains(userId));

    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (repliedMessage != null)
            MessageReplyBox(
              message: repliedMessage!,
              isSentByMe: repliedMessage!.userPreview.id == message.userPreview.id && isSentByMe
            ),

          if (!isSentByMe && isGroup)
            Text(message.userPreview.username,
              style: TextStyle(
                color: nameColour,
                fontWeight: FontWeight.bold,
                fontSize: 12
              )
            ),
          if (!isSentByMe) const SizedBox(height: 4),
          if (message.imageURLs != null) ChatBubbleImageCarousel(imageUrls: message.imageURLs!),
          if (message.recipes != null) ChatBubbleRecipeCarousel(recipePreviews: message.recipes!),
          if (message.imageURLs != null || message.recipes != null) const SizedBox(height: 4),
          if (message.textContent != null)
            Flexible(child: Text(message.textContent!,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              )
            )),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Align(
                alignment: Alignment.bottomRight,
                child: Text(DateFormat("HH:mm").format(message.sentDate!),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary,
                    fontSize: 10,
                  )
                ),
              ),
              const SizedBox(width: 4),
              if (isSentByMe)
                Icon(
                  readByAll
                    ? Icons.remove_red_eye_rounded
                    : Icons.remove_red_eye_outlined,
                  color: readByAll
                    ? Theme.of(context).colorScheme.tertiary
                    : Colors.white,
                  size: 11,
                )
            ],
          )
        ],
      ));
  }
}