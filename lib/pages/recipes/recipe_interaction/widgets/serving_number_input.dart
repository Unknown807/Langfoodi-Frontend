part of 'recipe_interaction_widgets.dart';

class ServingNumberInput extends StatelessWidget {
  const ServingNumberInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
      buildWhen: (p, c) => p.servingNumber != c.servingNumber
          || p.servingNumberValid != c.servingNumberValid,
      builder: (context, state) {
        final readonly = state.pageType == RecipeInteractionType.readonly;
        final isEmpty = state.servingNumber.value.isEmpty;
        return FormInput(
          readonly: readonly,
          textController: state.servingNumberTextController,
          keyboardType: TextInputType.number,
          innerPadding: const EdgeInsets.symmetric(horizontal: 5),
          outerPadding: const EdgeInsets.symmetric(horizontal: 10),
          labelText: (readonly && isEmpty) ? null : 'Number Of Servings',
          hintText: (readonly && isEmpty) ? 'Number of Servings' : null,
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