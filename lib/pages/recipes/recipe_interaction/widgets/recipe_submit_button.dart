part of 'recipe_interaction_widgets.dart';

class RecipeSubmitButton extends StatelessWidget {
  const RecipeSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
        builder: (context, state) {
          final String formType = state.pageType == RecipeInteractionType.edit ? "update" : "create";
          return IconButton(
            padding: const EdgeInsets.only(right: 20),
            icon: Icon(
              Icons.check_circle_outline,
              color: Theme.of(context).colorScheme.primary,
              size: 30,
            ),
            onPressed: () => showDialog(
                context: context,
                builder: (_) => BlocProvider<RecipeInteractionBloc>.value(
                    value: BlocProvider.of<RecipeInteractionBloc>(context),
                    child: CustomAlertDialog(
                      title: Text("${formType.capitalise()} Recipe"),
                      content: Text("Ready to $formType? (may take a second)"),
                      rightButtonText: formType.capitalise(),
                      rightButtonCallback: () => context
                          .read<RecipeInteractionBloc>()
                          .add(const RecipeFormSubmission()),
                    )
                )
            ),
          );
        }
    );
  }
}