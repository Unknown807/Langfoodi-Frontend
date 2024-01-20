part of 'recipe_interaction_widgets.dart';

class IngredientNameInput extends StatelessWidget {
  const IngredientNameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
        buildWhen: (p, c) => p.ingredientName != c.ingredientName
            || p.ingredientNameValid != c.ingredientNameValid,
        builder: (context, state) {
          return FormInput(
            textController: state.ingredientNameTextController,
            innerPadding: const EdgeInsets.only(left: 5),
            outerPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            hintText: "Flour",
            boxDecorationType: state.ingredientNameValid
                ? FormInputBoxDecorationType.textArea
                : FormInputBoxDecorationType.error,
            fontSize: RecipeInteractionPageConstants.inputFormFontSize,
            maxLines: 1,
            onSubmittedEventFunc: (value) {
              context
                  .read<RecipeInteractionBloc>()
                  .add(AddNewIngredientFromName(value));
            },
            eventFunc: (value) {
              context
                  .read<RecipeInteractionBloc>()
                  .add(IngredientNameChanged(value));
            });
        });
  }
}