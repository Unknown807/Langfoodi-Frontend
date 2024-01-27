part of 'recipe_interaction_widgets.dart';

class IngredientMeasurementInput extends StatelessWidget {
  const IngredientMeasurementInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
        buildWhen: (p, c) => p.ingredientMeasurement != c.ingredientMeasurement
            || p.ingredientMeasurementValid != c.ingredientMeasurementValid,
        builder: (context, state) {
          return FormInput(
              textController: state.ingredientMeasurementTextController,
              innerPadding: const EdgeInsets.symmetric(horizontal: 5),
              outerPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              hintText: "kg",
              boxDecorationType: state.ingredientMeasurementValid
                  ? FormInputBoxDecorationType.textArea
                  : FormInputBoxDecorationType.error,
              fontSize: RecipeInteractionPageConstants.inputFormFontSize,
              maxLines: 1,
              onSubmittedEventFunc: (value) {
                context
                    .read<RecipeInteractionBloc>()
                    .add(AddNewIngredientFromMeasurement(value));
              },
              eventFunc: (value) {
                context
                    .read<RecipeInteractionBloc>()
                    .add(IngredientMeasurementChanged(value));
              });
        });
  }
}
