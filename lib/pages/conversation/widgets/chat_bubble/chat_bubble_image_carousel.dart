part of 'package:recipe_social_media/pages/conversation/widgets/conversation_widgets.dart';

class ChatBubbleImageCarousel extends StatelessWidget {
  const ChatBubbleImageCarousel({
    super.key,
    required this.imageUrls
  });

  final List<String> imageUrls;

  @override
  Widget build(BuildContext context) {
    return Align(
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
          itemCount: imageUrls.length,
          itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
            return GestureDetector(
              onTap: () => context
                .read<NavigationRepository>()
                .goTo(context, "/cloudinary-image-view",
                arguments: ImageViewPageArguments(imageUrl: imageUrls[itemIndex])),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: context.read<ImageBuilder>().displayCloudinaryImage(
                  imageUrl: imageUrls[itemIndex],
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
      ));
  }
}