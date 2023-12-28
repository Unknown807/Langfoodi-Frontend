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
                      ? DottedBorder(
                      strokeWidth: 1.5,
                      color: Colors.blue,
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(10),
                      padding: const EdgeInsets.all(25),
                      child: const Center(child: Icon(Icons.image, size: 40, color: Colors.blue,)))
                      : AspectRatio(
                      aspectRatio: 1/1,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.file(File(state.recipeStepImagePath), fit: BoxFit.cover,))
                  ))
          );
        }
    );
  }
}