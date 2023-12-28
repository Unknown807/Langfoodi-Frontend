part of 'recipe_interaction_widgets.dart';

class CookingTimeInput extends StatelessWidget {
  const CookingTimeInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
        buildWhen: (p, c) => p.cookingTime != c.cookingTime
            || p.cookingTimeValid != c.cookingTimeValid,
        builder: (context, state) {
          return FormInput(
            textController: state.cookingTimeTextController,
            innerPadding: const EdgeInsets.only(left: 5),
            outerPadding: const EdgeInsets.symmetric(horizontal: 10),
            labelText: 'Cooking Time',
            boxDecorationType: state.cookingTimeValid
                ? FormInputBoxDecorationType.textArea
                : FormInputBoxDecorationType.error,
            fontSize: RecipeInteractionPageConstants.inputFormFontSize,
            eventFunc: (value) {
              context
                  .read<RecipeInteractionBloc>()
                  .add(CookingTimeChanged(value));
            },
          );
        }
    );
  }
}