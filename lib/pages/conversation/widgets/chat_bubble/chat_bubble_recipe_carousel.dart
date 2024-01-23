part of 'package:recipe_social_media/pages/conversation/widgets/conversation_widgets.dart';

class ChatBubbleRecipeCarousel extends StatelessWidget {
  const ChatBubbleRecipeCarousel({
    super.key,
    required this.recipePreviews
  });

  final List<RecipePreview> recipePreviews;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: 250,
          child: CarouselSlider.builder(
            options: CarouselOptions(
              enlargeFactor: 0.3,
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
              height: 300,
            ),
            itemCount: recipePreviews.length,
            itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  color: Theme.of(context).colorScheme.background,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Center(
                        child: Text(
                          recipePreviews[itemIndex].title.capitalise(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontWeight: FontWeight.w500,
                            fontSize: 16
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: context.read<ImageBuilder>().decideOnAndDisplayImage(
                          isAsset: true,
                          imageUrl: recipePreviews[itemIndex].thumbnailId ?? "assets/images/no_image.png",
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
                    ),
                    Center(
                      child: Text(
                        "Click To View",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontWeight: FontWeight.w500,
                          fontSize: 14
                        ),
                      ),
                    ),
                    const SizedBox(height: 2)
                  ],
              ));
            }
          ),
        )
      )
    );
  }
}