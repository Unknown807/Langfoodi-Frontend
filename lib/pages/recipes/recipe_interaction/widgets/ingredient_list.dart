part of 'recipe_interaction_widgets.dart';

class IngredientList extends StatelessWidget {
  const IngredientList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
      buildWhen: (p, c) => p.ingredientList.length != c.ingredientList.length,
      builder: (context, state) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: state.ingredientList.length,
          itemBuilder: (context, index) {
            final ing = state.ingredientList[index];
            return Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Expanded(child: Text(
                    "${ing.name}, ${ing.quantity.toStringAsFixed(ing.quantity.truncateToDouble() == ing.quantity ? 0 : 3)} ${ing.unitOfMeasurement}",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  )),
                  IconButton(
                    splashRadius: 20,
                    onPressed: () => showDialog(
                      context: context,
                      builder: (_) => BlocProvider<RecipeInteractionBloc>.value(
                        value: BlocProvider.of<RecipeInteractionBloc>(context),
                        child: CustomAlertDialog(
                          title: const Text("Remove Ingredient"),
                          content: Text("Are you sure you want to remove ${ing.name}"),
                          rightButtonText: "Remove",
                          rightButtonCallback: () => context.read<RecipeInteractionBloc>().add(RemoveIngredient(index)),
                        )
                      )
                    ),
                    icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.inversePrimary)
                  )
                ],
              ));
          },
        );
      },
    );
  }
}