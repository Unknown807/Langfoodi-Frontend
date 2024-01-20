part of 'recipe_interaction_widgets.dart';

class RecipeTagInput extends StatelessWidget {
  const RecipeTagInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
        builder: (context, state) {
          return Row(
              children: <Widget>[
                Flexible(
                    flex: 6,
                    child: FormInput(
                      textController: state.recipeTagTextController,
                      hintText: "Type Tags Here",
                      boxDecorationType: state.recipeTagValid
                          ? FormInputBoxDecorationType.textArea
                          : FormInputBoxDecorationType.error,
                      fontSize: RecipeInteractionPageConstants.inputFormFontSize,
                      maxLines: 1,
                      outerPadding: const EdgeInsets.only(top: 10),
                      innerPadding: const EdgeInsets.symmetric(horizontal: 8),
                      eventFunc: (value) {
                        context
                            .read<RecipeInteractionBloc>()
                            .add(RecipeTagChanged(value));
                      },
                      onSubmittedEventFunc: (value) {
                        context
                            .read<RecipeInteractionBloc>()
                            .add(AddNewRecipeTagFromField(value));
                      },
                    )
                ),
                Flexible(
                  flex: 1,
                  child: IconButton(
                    padding: const EdgeInsets.only(right: 1),
                    splashRadius: 20,
                    icon: Icon(
                      Icons.add_circle_outline_rounded,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 25),
                    onPressed: () => context
                      .read<RecipeInteractionBloc>()
                      .add(const AddNewRecipeTagFromButton()),
                  ),
                ),
              ]
          );
        }
    );
  }
}