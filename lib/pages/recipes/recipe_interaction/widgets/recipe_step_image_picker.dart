part of 'recipe_interaction_widgets.dart';

class RecipeStepImagePicker extends StatelessWidget {
  const RecipeStepImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
        buildWhen: (p, c) => p.recipeStepImagePath != c.recipeStepImagePath,
        builder: (context, state) {
          return GestureDetector(
              onTap: () async {
                final selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                if (selectedImage != null && context.mounted) {
                  context
                      .read<RecipeInteractionBloc>()
                      .add(RecipeStepImagePicked(selectedImage.path));
                }
              },
              child: Padding(
                  padding: const EdgeInsets.only(top: 5, left: 5, bottom: 5),
                  child: state.recipeStepImagePath.isEmpty
                      ? CustomIconTile(
                          icon: Icons.image,
                          borderStrokeWidth: 1.5,
                          iconColor: Theme.of(context).colorScheme.tertiary,
                          tileColor: Theme.of(context).colorScheme.tertiary)
                      : AspectRatio(
                          aspectRatio: 1/1,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: context
                                .read<ImageBuilder>()
                                .displayLocalImage(
                                  imagePath: state.recipeStepImagePath,
                                  errorBuilder: (context, obj1, obj2) {
                                    return CustomIconTile(
                                      icon: Icons.error,
                                      iconColor: Theme.of(context).colorScheme.error,
                                      tileColor: Theme.of(context).colorScheme.error,
                                    );
                                  })
                          )
                  ))
          );
        }
    );
  }
}