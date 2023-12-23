part of 'recipe_interaction_widgets.dart';

class RecipeSubmitButton extends StatelessWidget {
  const RecipeSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
        builder: (context, state) {
          final String formType = state.pageType == RecipeInteractionType.edit ? "Edit" : "Create";
          return IconButton(
            padding: const EdgeInsets.only(right: 20),
            icon: const Icon(
              Icons.check_circle_outline,
              color: Colors.lightGreenAccent,
              size: 30,
            ),
            onPressed: () => showDialog(
                context: context,
                builder: (_) => BlocProvider<RecipeInteractionBloc>.value(
                    value: BlocProvider.of<RecipeInteractionBloc>(context),
                    child: CustomAlertDialog(
                      title: Text("$formType Recipe"),
                      content: const Text("Ready to submit? (may take a second)"),
                      rightButtonText: formType,
                      rightButtonCallback: () => context.read<RecipeInteractionBloc>().add(const RecipeFormSubmission()),
                    )
                )
            ),
          );
        }
    );
  }
}