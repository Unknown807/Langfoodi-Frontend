part of 'recipe_interaction_widgets.dart';

class ServingQuantityInput extends StatelessWidget {
  const ServingQuantityInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
        buildWhen: (p, c) => p.servingQuantity != c.servingQuantity
            || p.servingQuantityValid != c.servingQuantityValid,
        builder: (context, state) {
          return FormInput(
            textController: state.servingQuantityTextController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            innerPadding: const EdgeInsets.only(left: 5),
            outerPadding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
            labelText: 'Serving Quantity',
            boxDecorationType: state.servingQuantityValid
                ? FormInputBoxDecorationType.textArea
                : FormInputBoxDecorationType.error,
            fontSize: RecipeInteractionPageConstants.inputFormFontSize,
            eventFunc: (value) {
              context
                  .read<RecipeInteractionBloc>()
                  .add(ServingQuantityChanged(value));
            },
          );
        }
    );
  }
}