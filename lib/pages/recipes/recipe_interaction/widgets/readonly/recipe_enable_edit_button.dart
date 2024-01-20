part of 'package:recipe_social_media/pages/recipes/recipe_interaction/widgets/recipe_interaction_widgets.dart';

class RecipeEnableEditButton extends StatelessWidget {
  const RecipeEnableEditButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
      builder: (context, state) {
        return IconButton(
          padding: const EdgeInsets.only(right: 20),
          icon: Icon(
            Icons.edit,
            color: Theme.of(context).colorScheme.secondary,
            size: 30
          ),
          onPressed: () => showDialog(
              context: context,
              builder: (_) => BlocProvider<RecipeInteractionBloc>.value(
                  value: BlocProvider.of<RecipeInteractionBloc>(context),
                  child: CustomAlertDialog(
                    title: const Text("Edit Recipe"),
                    content: const Text("Do you want to edit your recipe?"),
                    rightButtonText: "Edit",
                    rightButtonCallback: () => context
                        .read<RecipeInteractionBloc>()
                        .add(const EnableRecipeEditing()),
                  )
              )
          )
        );
      },
    );
  }
}