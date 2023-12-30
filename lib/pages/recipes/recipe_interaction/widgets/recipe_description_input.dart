part of 'recipe_interaction_widgets.dart';

class RecipeDescriptionInput extends StatelessWidget {
  const RecipeDescriptionInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
        buildWhen: (p, c) => p.recipeDescription != c.recipeDescription
            || p.recipeDescriptionValid != c.recipeDescriptionValid
            || p.pageType != c.pageType,
        builder: (context, state) {
          return FormInput(
              readonly: state.pageType == RecipeInteractionType.readonly,
              textController: state.recipeDescriptionTextController,
              hintText: "Recipe Description Here",
              boxDecorationType: state.recipeDescriptionValid
                  ? FormInputBoxDecorationType.textArea
                  : FormInputBoxDecorationType.error,
              fontSize: RecipeInteractionPageConstants.inputFormFontSize,
              maxLines: 6,
              eventFunc: (value) {
                context
                    .read<RecipeInteractionBloc>()
                    .add(RecipeDescriptionChanged(value));
              }
          );
        }
    );
  }
}