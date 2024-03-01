part of 'package:recipe_social_media/pages/recipes/recipe_interaction/widgets/recipe_interaction_widgets.dart';

/*
Displays the recipe title using a Text widget.
*/
class ReadOnlyRecipeTitle extends StatelessWidget {
  const ReadOnlyRecipeTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
        builder: (context, state) {
          return Text(
            state.recipeTitle.value,
            style: const TextStyle(fontSize: 20),
            overflow: TextOverflow.ellipsis,
            maxLines: 2);
        });
  }
}
