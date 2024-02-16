part of 'package:recipe_social_media/pages/conversation/widgets/conversation_widgets.dart';

class ChatBubbleRecipeCarousel extends StatelessWidget {
  const ChatBubbleRecipeCarousel({
    super.key,
    required this.recipePreviews
  });

  final List<RecipePreview> recipePreviews;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: 250,
        child: CarouselSlider.builder(
          options: CarouselOptions(
            enlargeFactor: 0.3,
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
            height: 150,
          ),
          itemCount: recipePreviews.length,
          itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
            return GestureDetector(
              onTap: () => context
                .read<ConversationBloc>()
                .add(GoToInteractionPageAndExpectResult(
                  context, RecipeInteractionPageArguments(
                    pageType: RecipeInteractionType.readonly,
                    recipeId: recipePreviews[itemIndex].id
                    ))),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  color: Theme.of(context).colorScheme.background.withAlpha(150),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                        child: context.read<ImageBuilder>().decideOnAndDisplayImage(
                          isAsset: true,
                          imageUrl: recipePreviews[itemIndex].thumbnailId ?? "assets/images/no_image.png",
                          transformationType: ImageTransformationType.lowHorizontal,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          recipePreviews[itemIndex].title.capitalise(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontWeight: FontWeight.w500,
                            fontSize: 16
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.fastfood_rounded,
                          size: 15,
                        )
                      ],
                    ),
                    const SizedBox(height: 2)
                  ],
                )
              )
            );
          }
        ),
      )
    );
  }
}