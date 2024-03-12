part of 'package:recipe_social_media/pages/recipes/recipe_interaction/widgets/recipe_interaction_widgets.dart';

class ReadonlyRecipeThumbnail extends StatelessWidget {
  const ReadonlyRecipeThumbnail({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
      builder: (context, state) {
        final noImage = state.recipeThumbnailPath.isEmpty;
        return Padding(
            padding: const EdgeInsets.only(top: 5, right: 5),
            child: AspectRatio(
                aspectRatio: 4 / 3,
                child: GestureDetector(
                  onTap: noImage ? null : () => context
                    .read<NavigationRepository>()
                    .goTo(context, "/cloudinary-image-view",
                      arguments: ImageViewPageArguments(imageUrl: state.recipeThumbnailPath)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: context.read<ImageBuilder>().decideOnAndDisplayImage(
                      isAsset: true,
                      imageUrl: noImage ? "assets/images/no_image.png" : state.recipeThumbnailPath,
                      transformationType: ImageTransformationType.standard,
                      errorBuilder: (context, obj1, obj2) {
                        return CustomIconTile(
                          icon: Icons.error,
                          iconColor: Theme.of(context).colorScheme.error,
                          tileColor: Theme.of(context).colorScheme.error,
                        );
                      },
                    ),
                ))));
      },
    );
  }
}
