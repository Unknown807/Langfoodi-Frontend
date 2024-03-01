part of 'package:recipe_social_media/pages/recipes/recipe_interaction/widgets/recipe_interaction_widgets.dart';

/*
Displays the recipe description.
*/
class ReadOnlyDescription extends StatelessWidget {
  const ReadOnlyDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
        builder: (context, state) {
      return (SizedBox(
          height: 150,
          child: SingleChildScrollView(
              child: Text(
            state.recipeDescription.value,
            style: const TextStyle(fontSize: 14),
          ))));
    });
  }
}
