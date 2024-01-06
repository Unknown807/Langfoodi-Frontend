part of 'recipe_interaction_widgets.dart';

class IngredientSubmitButton extends StatelessWidget {
  const IngredientSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 10),
          child: SizedBox(
            width: 20,
            height: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              child: const Icon(Icons.add, size: 20),
              onPressed: () {
                // context
                //   .read<RecipeInteractionBloc>()
                //   .add(const AddNewRecipeStepFromButton());
              },
            ),
          ));
      },
    );
  }
}