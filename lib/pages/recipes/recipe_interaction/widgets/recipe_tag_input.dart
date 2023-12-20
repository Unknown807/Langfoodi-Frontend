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
                          ? FormInputBoxDecorationType.underlined
                          : FormInputBoxDecorationType.underlinedError,
                      fontSize: RecipeInteractionPageConstants.inputFormFontSize,
                      maxLines: 1,
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
                    icon: const Icon(Icons.add_circle_outline_rounded, size: 25, color: Colors.blue,),
                    onPressed: () {
                      context
                          .read<RecipeInteractionBloc>()
                          .add(const AddNewRecipeTagFromButton());
                    },
                  ),
                ),
              ]
          );
        }
    );
  }
}