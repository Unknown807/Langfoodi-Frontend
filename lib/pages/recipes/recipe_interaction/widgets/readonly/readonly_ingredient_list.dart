part of 'package:recipe_social_media/pages/recipes/recipe_interaction/widgets/recipe_interaction_widgets.dart';

class ReadonlyIngredientList extends StatelessWidget {
  const ReadonlyIngredientList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
      buildWhen: (p, c) => p.ingredientList.length != c.ingredientList.length,
      builder: (context, state) {
        return ListView.separated(
          shrinkWrap: true,
          itemCount: state.ingredientList.length,
          separatorBuilder: (context, _) => const SizedBox(height: 20),
          itemBuilder: (context, index) {
            final ing = state.ingredientList[index];
            return Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(
                  ing.name,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.w400,
                    fontSize: 20),
                ),
                Text(
                  "${ing.quantity.toStringAsFixed(ing.quantity.truncateToDouble() == ing.quantity ? 0 : 3)} ${ing.unitOfMeasurement}",
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).hintColor,
                      fontWeight: FontWeight.w400),
                ),
              ]));
          });
      });
  }
}
