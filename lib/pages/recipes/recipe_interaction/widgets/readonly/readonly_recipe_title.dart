part of 'package:recipe_social_media/pages/recipes/recipe_interaction/widgets/recipe_interaction_widgets.dart';

class ReadOnlyRecipeTitle extends StatelessWidget {
  const ReadOnlyRecipeTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
        builder: (context, state) {
          return Text(
            state.recipeTitle.value,
            style: TextStyle(fontSize: 20));
        });
  }
}
