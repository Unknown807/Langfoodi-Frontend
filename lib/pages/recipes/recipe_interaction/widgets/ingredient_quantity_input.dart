part of 'recipe_interaction_widgets.dart';

class IngredientQuantityInput extends StatelessWidget {
  const IngredientQuantityInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
        buildWhen: (p, c) => p.ingredientQuantity != c.ingredientQuantity
            || p.ingredientQuantityValid != c.ingredientQuantityValid,
        builder: (context, state) {
          return FormInput(
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              textController: state.ingredientQuantityTextController,
              innerPadding: const EdgeInsets.only(left: 5),
              outerPadding: const EdgeInsets.symmetric(vertical: 5),
              hintText: "1",
              boxDecorationType: state.ingredientQuantityValid
                  ? FormInputBoxDecorationType.textArea
                  : FormInputBoxDecorationType.error,
              fontSize: RecipeInteractionPageConstants.inputFormFontSize,
              maxLines: 1,
              onSubmittedEventFunc: (value) {
                context
                    .read<RecipeInteractionBloc>()
                    .add(AddNewIngredientFromQuantity(value));
              },
              eventFunc: (value) {
                context
                    .read<RecipeInteractionBloc>()
                    .add(IngredientQuantityChanged(value));
              });
        });
  }
}