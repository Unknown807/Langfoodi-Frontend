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
                child: AspectRatio(
                    aspectRatio: 4/3,
                    child: state.recipeThumbnailPath.isEmpty
                    ? const CustomIconTile(
                      icon: Icons.image,
                      tileColor: Colors.blue)
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: File(state.recipeThumbnailPath).existsSync()
                          ? Image.file(
                              File(state.recipeThumbnailPath),
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                return const CustomIconTile(
                                  icon: Icons.close,
                                  tileColor: Colors.red,
                                  borderStrokeWidth: 3,
                                );
                              })
                          : CldImageWidget(
                              publicId: state.recipeThumbnailPath,
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context, String url, Object error) {
                                return const CustomIconTile(
                                  icon: Icons.close,
                                  tileColor: Colors.red,
                                  borderStrokeWidth: 3,
                                );
                              })
                ))),
          );
        }
    );
  }
}