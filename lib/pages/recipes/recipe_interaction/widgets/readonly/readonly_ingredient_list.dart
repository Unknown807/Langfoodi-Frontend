part of 'package:recipe_social_media/pages/recipes/recipe_interaction/widgets/recipe_interaction_widgets.dart';

class ReadonlyIngredientList extends StatelessWidget {
  const ReadonlyIngredientList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
        buildWhen: (p, c) => p.ingredientList.length != c.ingredientList.length,
        builder: (context, state) {
          return ListView.separated(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.ingredientList.length,
              separatorBuilder: (context, _) => const SizedBox(height: 14),
              itemBuilder: (context, index) {
                final ing = state.ingredientList[index];
                return Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: 140,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Theme.of(context).colorScheme.background,
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 5, bottom: 5),
                                  child: Center(
                                      child: Text(
                                    "${ing.quantity.toStringAsFixed(ing.quantity.truncateToDouble() == ing.quantity ? 0 : 3)} ${ing.unitOfMeasurement}",
                                    style: TextStyle(
                                        color: Theme.of(context).colorScheme.onBackground,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )))),
                          const SizedBox(width: 8),
                          Expanded(child:
                              Text(
                                ing.name,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              )),
                        ]));
              });
        });
  }
}
