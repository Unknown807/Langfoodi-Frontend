part of 'recipe_interaction_widgets.dart';

class RecipeTitleInput extends StatelessWidget {
  const RecipeTitleInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
        buildWhen: (p, c) => p.recipeTitle != c.recipeTitle
            || p.recipeTitleValid != c.recipeTitleValid,
        builder: (context, state) {
          return FormInput(
              readonly: state.pageType == RecipeInteractionType.readonly,
              textController: state.recipeTitleTextController,
              hintText: "Recipe Name Here",
              boxDecorationType: state.recipeTitleValid
                  ? FormInputBoxDecorationType.minimal
                  : FormInputBoxDecorationType.error,
              innerPadding: EdgeInsets.zero,
              outerPadding: const EdgeInsets.only(bottom: 5),
              textAlign: TextAlign.center,
              fontSize: 20,
              eventFunc: (value) {
                context
                    .read<RecipeInteractionBloc>()
                    .add(RecipeTitleChanged(value));
              }
          );
        });
  }
}