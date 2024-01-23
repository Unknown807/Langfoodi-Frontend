part of 'package:recipe_social_media/pages/conversation/widgets/conversation_widgets.dart';

class ChatBubbleRecipeCarousel extends StatelessWidget {
  const ChatBubbleRecipeCarousel({
    super.key,
    required this.recipePreviews
  });

  //TODO: these will be RecipePreviewDtos instead of just strings
  final List<String> recipePreviews;

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
          itemCount: recipePreviews.length,
          itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: context.read<ImageBuilder>().displayCloudinaryImage(
                imageUrl: recipePreviews[itemIndex],
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
            );
          }
        ),
      )
    );
  }
}