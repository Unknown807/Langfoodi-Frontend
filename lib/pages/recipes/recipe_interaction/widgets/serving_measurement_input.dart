part of 'recipe_interaction_widgets.dart';

class ServingMeasurementInput extends StatelessWidget {
  const ServingMeasurementInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
        buildWhen: (p, c) => p.servingMeasurement != c.servingMeasurement
            || p.servingMeasurementValid != c.servingMeasurementValid,
        builder: (context, state) {
          final readonly = state.pageType == RecipeInteractionType.readonly;
          final isEmpty = state.servingMeasurement.value.isEmpty;
          return FormInput(
            readonly: readonly,
            textController: state.servingMeasurementTextController,
            innerPadding: const EdgeInsets.symmetric(horizontal: 5),
            outerPadding: const EdgeInsets.fromLTRB(0, 0, 10, 5),
            labelText: (readonly && isEmpty) ? null : 'Serving Unit',
            hintText: (readonly && isEmpty) ? 'Serving Unit' : null,
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