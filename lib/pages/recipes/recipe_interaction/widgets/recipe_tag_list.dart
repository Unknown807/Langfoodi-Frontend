part of 'recipe_interaction_widgets.dart';

class RecipeTagList extends StatelessWidget {
  const RecipeTagList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
        buildWhen: (p, c) => p.recipeTagList.length != c.recipeTagList.length,
        builder: (context, state) {
          return Wrap(
              runSpacing: 5,
              spacing: 10,
              children:
              List.generate(
                  state.recipeTagList.length,
                      (index) {
                    final label = state.recipeTagList[index];
                    return Chip(
                      label: Text(label,
                          style: const TextStyle(color: Color.fromRGBO(98, 151, 246, 1))),
                      backgroundColor: const Color.fromRGBO(229, 239, 255, 1),
                      deleteButtonTooltipMessage: "",
                      deleteIcon: const Icon(Icons.close_rounded,
                          color: Color.fromRGBO(98, 151, 246, 1),
                          size: 17),
                      onDeleted: () {
                        context
                            .read<RecipeInteractionBloc>()
                            .add(RemoveRecipeTag(index));
                      },
                    );
                  }
              )
          );
        }
    );
  }
}