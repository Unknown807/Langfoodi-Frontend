part of 'conversation_widgets.dart';

class RecipeAttachmentBox extends StatelessWidget {
  const RecipeAttachmentBox({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationBloc, ConversationState>(
      buildWhen: (p, c) => p.attachedRecipes != c.attachedRecipes,
      builder: (context, state) {
        return state.attachedRecipes.isEmpty
          ? const SizedBox.shrink()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  width: double.infinity,
                  height: 40,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: state.attachedRecipes.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(width: 8);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      final recipe = state.attachedRecipes[index];
                      return Chip(
                        backgroundColor: Theme.of(context).colorScheme.tertiary.withAlpha(50),
                        label: Text(
                          recipe.title,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
          );
      },
    );
  }
}