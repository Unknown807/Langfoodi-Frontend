part of 'recipe_interaction_widgets.dart';

class KilocaloriesInput extends StatelessWidget {
  const KilocaloriesInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
        buildWhen: (p, c) => p.kilocalories != c.kilocalories
            || p.kilocaloriesValid != c.kilocaloriesValid,
        builder: (context, state) {
          final readonly = state.pageType == RecipeInteractionType.readonly;
          final isEmpty = state.kilocalories.value.isEmpty;
          return FormInput(
            readonly: readonly,
            textController: state.kilocaloriesTextController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            innerPadding: const EdgeInsets.symmetric(horizontal: 5),
            outerPadding: const EdgeInsets.fromLTRB(0, 0, 10, 5),
            labelText: (readonly && isEmpty) ? null : 'Kilocalories',
            hintText: (readonly && isEmpty) ? 'Kilocalories' : null,
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