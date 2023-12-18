part of 'recipe_interaction_widgets.dart';

class RecipeDescriptionInput extends StatelessWidget {
  const RecipeDescriptionInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
        buildWhen: (p, c) => p.recipeDescription != c.recipeDescription
            || p.recipeDescriptionValid != c.recipeDescriptionValid,
        builder: (context, state) {
          return FormInput(
              textController: state.recipeDescriptionTextController,
              hint: "Recipe Description Here",
              boxDecorationType: state.recipeDescriptionValid
                  ? FormInputBoxDecorationType.textArea
                  : FormInputBoxDecorationType.error,
              fontSize: RecipeInteractionPageConstants.inputFormFontSize,
              maxLines: 6,
              eventFunc: (value) {
                context
                    .read<RecipeInteractionBloc>()
                    .add(RecipeDescriptionChanged(value));
              }
          );
        }
    );
  }
}