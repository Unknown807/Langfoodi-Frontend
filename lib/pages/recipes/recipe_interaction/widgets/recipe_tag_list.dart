part of 'recipe_interaction_widgets.dart';

class RecipeTagList extends StatelessWidget {
  const RecipeTagList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
      buildWhen: (p, c) =>
        p.recipeTagList.length != c.recipeTagList.length
        || p.pageType != c.pageType,
      builder: (context, state) {
        return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Wrap(
          spacing: 10,
          children:
          List.generate(
            state.recipeTagList.length,
            (index) {
              final label = state.recipeTagList[index];
              return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Chip(
                label: Text(label,
                  style: TextStyle(color: Theme.of(context).colorScheme.onBackground)),
                backgroundColor: Theme.of(context).colorScheme.background,
                shape: const StadiumBorder(side: BorderSide(style: BorderStyle.none)),
                deleteButtonTooltipMessage: "",
                deleteIcon: Icon(Icons.close_rounded,
                  color: Theme.of(context).colorScheme.tertiary,
                  size: 17),
                onDeleted: state.pageType == RecipeInteractionType.readonly
                  ? null
                  : () => context.read<RecipeInteractionBloc>().add(RemoveRecipeTag(index)),
              ));
            }
          )
        )]);
      }
    );
  }
}