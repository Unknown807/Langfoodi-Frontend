part of 'recipe_interaction_widgets.dart';

class RecipeThumbnailPicker extends StatelessWidget {
  const RecipeThumbnailPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
        buildWhen: (p, c) => p.recipeThumbnailPath != c.recipeThumbnailPath,
        builder: (context, state) {
          return GestureDetector(
            onTap: () async {
              final selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
              if (selectedImage != null && context.mounted) {
                context.read<RecipeInteractionBloc>().add(RecipeThumbnailPicked(selectedImage.path));
              }
            },
            child: Padding(
                padding: const EdgeInsets.only(top: 5, right: 5),
                child: AspectRatio(
                    aspectRatio: 4 / 3,
                    child: state.recipeThumbnailPath.isEmpty
                        ? CustomIconTile(
                            icon: Icons.image,
                            iconColor: Theme.of(context).colorScheme.tertiary,
                            tileColor: Theme.of(context).colorScheme.tertiary)
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: context.read<ImageBuilder>().decideOnAndDisplayImage(
                              imageUrl: state.recipeThumbnailPath,
                              transformationType: ImageTransformationType.standard,
                              errorBuilder: (context, obj1, obj2) {
                                return CustomIconTile(
                                  icon: Icons.error,
                                  iconColor: Theme.of(context).colorScheme.error,
                                  tileColor: Theme.of(context).colorScheme.error,
                                );
                              },
                            ),
                          ))),
          );
        });
  }
}
