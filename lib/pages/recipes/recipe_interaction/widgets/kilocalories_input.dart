part of 'recipe_interaction_widgets.dart';

class KilocaloriesInput extends StatelessWidget {
  const KilocaloriesInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
        buildWhen: (p, c) => p.kilocalories != c.kilocalories
            || p.kilocaloriesValid != c.kilocaloriesValid,
        builder: (context, state) {
          return FormInput(
            textController: state.kilocaloriesTextController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            innerPadding: const EdgeInsets.only(left: 5),
            outerPadding: const EdgeInsets.fromLTRB(0, 0, 10, 5),
            hint: 'Kilocalories',
            boxDecorationType: state.kilocaloriesValid
                ? FormInputBoxDecorationType.textArea
                : FormInputBoxDecorationType.error,
            fontSize: RecipeInteractionPageConstants.inputFormFontSize,
            eventFunc: (value) {
              context
                  .read<RecipeInteractionBloc>()
                  .add(KilocaloriesChanged(value));
            },
          );
        }
    );
  }
}