part of 'conversation_widgets.dart';

class ChatBubbleContent extends StatelessWidget {
  const ChatBubbleContent({
    super.key,
    required this.isSentByMe,
    required this.message,
    this.nameColour
  });

  final bool isSentByMe;
  final Message message;
  final Color? nameColour;

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
                color: nameColour,
                fontWeight: FontWeight.bold,
                fontSize: 12
              )
            ),
          if (!isSentByMe) const SizedBox(height: 4),
          if (message.imageURLs != null)
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 250,
                child: CarouselSlider.builder(
                  options: CarouselOptions(
                    enlargeFactor: 0.2,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true,
                    height: 300,
                  ),
                  itemCount: message.imageURLs!.length,
                  itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
                    return GestureDetector(
                      onTap: () => context
                        .read<NavigationRepository>()
                        .goTo(context, "/cloudinary-image-view",
                        arguments: ImageViewPageArguments(imageUrl: message.imageURLs![itemIndex])),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: context.read<ImageBuilder>().displayCloudinaryImage(
                          imageUrl: message.imageURLs![itemIndex],
                          transformationType: ImageTransformationType.low,
                          errorBuilder: (context, obj1, obj2) {
                            return CustomIconTile(
                              padding: null,
                              icon: Icons.error,
                              backgroundColor: Theme.of(context).colorScheme.background,
                              iconColor: Theme.of(context).colorScheme.error,
                              tileColor: Theme.of(context).colorScheme.error,
                            );
                          },
                        ),
                      )
                    );
                  }
                ),
            )),
          if (message.imageURLs != null) const SizedBox(height: 4),
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