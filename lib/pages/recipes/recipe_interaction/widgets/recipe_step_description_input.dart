part of 'recipe_interaction_widgets.dart';

class RecipeStepDescriptionInput extends StatelessWidget {
  const RecipeStepDescriptionInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
        buildWhen: (p, c) => p.recipeStepDescription != c.recipeStepDescription
            || p.recipeDescriptionValid != c.recipeDescriptionValid,
        builder: (context, state) {
          return FormInput(
            textController: state.recipeStepDescriptionTextController,
            innerPadding: const EdgeInsets.only(left: 5),
            outerPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            hint: "Write step here and enter to submit",
            boxDecorationType: state.recipeStepDescriptionValid
                ? FormInputBoxDecorationType.textArea
                : FormInputBoxDecorationType.error,
            fontSize: RecipeInteractionPageConstants.inputFormFontSize,
            maxLines: 6,
            onSubmittedEventFunc: (value) {
              context
                  .read<RecipeInteractionBloc>()
                  .add(AddNewRecipeStepFromDescription(value));
            },
            eventFunc: (value) {
              context
                  .read<RecipeInteractionBloc>()
                  .add(RecipeStepDescriptionChanged(value));
            },
          );
        }
    );
  }
}