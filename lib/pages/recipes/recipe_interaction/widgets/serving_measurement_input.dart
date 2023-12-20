part of 'recipe_interaction_widgets.dart';

class ServingMeasurementInput extends StatelessWidget {
  const ServingMeasurementInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
        buildWhen: (p, c) => p.servingMeasurement != c.servingMeasurement
            || p.servingMeasurementValid != c.servingMeasurementValid,
        builder: (context, state) {
          return FormInput(
            textController: state.servingMeasurementTextController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            innerPadding: const EdgeInsets.only(left: 5),
            outerPadding: const EdgeInsets.fromLTRB(0, 0, 10, 5),
            labelText: 'Serving Unit Of Measurement',
            boxDecorationType: state.servingMeasurementValid
                ? FormInputBoxDecorationType.textArea
                : FormInputBoxDecorationType.error,
            fontSize: RecipeInteractionPageConstants.inputFormFontSize,
            eventFunc: (value) {
              context
                  .read<RecipeInteractionBloc>()
                  .add(ServingMeasurementChanged(value));
            },
          );
        }
    );
  }
}