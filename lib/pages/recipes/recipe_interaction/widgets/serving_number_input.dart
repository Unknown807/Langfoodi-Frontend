part of 'recipe_interaction_widgets.dart';

class ServingNumberInput extends StatelessWidget {
  const ServingNumberInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
      buildWhen: (p, c) => p.servingNumber != c.servingNumber
          || p.servingNumberValid != c.servingNumberValid,
      builder: (context, state) {
        return FormInput(
          textController: state.servingNumberTextController,
          keyboardType: TextInputType.number,
          innerPadding: const EdgeInsets.only(left: 5),
          outerPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          hint: 'Number Of Servings',
          boxDecorationType: state.servingNumberValid
              ? FormInputBoxDecorationType.textArea
              : FormInputBoxDecorationType.error,
          fontSize: RecipeInteractionPageConstants.inputFormFontSize,
          eventFunc: (value) {
            context
                .read<RecipeInteractionBloc>()
                .add(ServingNumberChanged(value));
          },
        );
      },
    );
  }
}