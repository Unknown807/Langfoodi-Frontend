part of 'package:recipe_social_media/pages/recipes/recipe_interaction/widgets/recipe_interaction_widgets.dart';

class ReadonlyRecipeStepList extends StatelessWidget {
  const ReadonlyRecipeStepList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(builder: (context, state) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: state.recipeStepList.length,
        itemBuilder: (context, index) {
          final step = state.recipeStepList[index];
          return Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: (index > 0 ? 30 : 0)),
              child: Column(children: <Widget>[
                step.imageUrl == null
                    ? const SizedBox(height: 0, width: 0)
                    : GestureDetector(
                        onTap: () => context
                            .read<NavigationRepository>()
                            .goTo(context, "/cloudinary-image-view",
                              arguments: ImageViewPageArguments(
                                imageUrl: step.imageUrl!)),
                        child: AspectRatio(
                          aspectRatio: 3 / 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: context.read<ImageBuilder>().displayCloudinaryImage(
                                imageUrl: step.imageUrl!,
                                transformationType: ImageTransformationType.standard,
                                errorBuilder: (context, obj1, obj2) {
                                  return const CustomIconTile(
                                    icon: Icons.close,
                                    tileColor: Colors.red,
                                  );
                                },
                              ),
                      ))),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            "${index + 1}. ${step.text}",
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                          ))
                      )
                ])
              ]));
        },
      );
    });
  }
}
