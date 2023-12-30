part of 'package:recipe_social_media/pages/recipes/recipe_interaction/widgets/recipe_interaction_widgets.dart';

class ReadonlyRecipeThumbnail extends StatelessWidget {
  const ReadonlyRecipeThumbnail({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
      builder: (context, state) {
        return Padding(
            padding: const EdgeInsets.only(top: 5, right: 5),
            child: AspectRatio(
                aspectRatio: 4 / 3,
                child: state.recipeThumbnailPath.isEmpty
                    ? const SizedBox()
                    : GestureDetector(
                        onTap: () => context
                          .read<NavigationRepository>()
                          .goTo(context, "/cloudinary-image-view",
                            arguments: ImageViewPageArguments(imageUrl: state.recipeThumbnailPath)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: context.read<ImageBuilder>().decideOnAndDisplayImage(
                                imageUrl: state.recipeThumbnailPath,
                                transformationType: ImageTransformationType.standard,
                                errorBuilder: (context, obj1, obj2) {
                                  return const CustomIconTile(
                                    icon: Icons.close,
                                    iconColor: Colors.red,
                                    tileColor: Colors.red,
                                  );
                                },
                              ),
                      ))));
      },
    );
  }
}
