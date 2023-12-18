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
                context
                    .read<RecipeInteractionBloc>()
                    .add(RecipeThumbnailPicked(selectedImage.path));
              }
            } ,
            child: Padding(
                padding: const EdgeInsets.only(top: 5, right: 5),
                child: state.recipeThumbnailPath.isEmpty
                    ? DottedBorder(
                    strokeWidth: 1.5,
                    color: Colors.blue,
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(10),
                    padding: const EdgeInsets.all(25),
                    child: const Center(child: Icon(Icons.image, size: 70, color: Colors.blue,)))
                    : AspectRatio(
                    aspectRatio: 4/3,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.file(File(state.recipeThumbnailPath), fit: BoxFit.cover,))
                )),
          );
        }
    );
  }
}