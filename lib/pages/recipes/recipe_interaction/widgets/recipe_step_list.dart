part of 'recipe_interaction_widgets.dart';

class RecipeStepList extends StatelessWidget {
  const RecipeStepList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
      builder: (context, state) {
        return ReorderableListView.builder(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          buildDefaultDragHandles: false,
          itemCount: state.recipeStepList.length,
          onReorder: (int oldIndex, int newIndex) {
            context
                .read<RecipeInteractionBloc>()
                .add(ReorderRecipeStepList(oldIndex, newIndex));
          },
          itemBuilder: (context, index) {
            final step = state.recipeStepList[index];
            return ReorderableDelayedDragStartListener(
              index: index,
              key: ValueKey(index),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                child: Column(
                  children: <Widget>[
                    step.imageUrl == null
                      ? const SizedBox(height: 0, width: 0)
                      : AspectRatio(
                          aspectRatio: 3/1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: context.read<ImageBuilder>().decideOnAndDisplayImage(
                              imageUrl: step.imageUrl!,
                              transformationType: ImageTransformationType.standard,
                              errorBuilder: (context, obj1, obj2) {
                                return CustomIconTile(
                                  icon: Icons.error,
                                  iconColor: Theme.of(context).colorScheme.error,
                                  tileColor: Theme.of(context).colorScheme.error,
                                );
                              },
                            ),
                          )
                        ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(padding: const EdgeInsets.only(top:5, bottom: 5),
                            child: Text(
                              "${index+1}. ${step.text}",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onBackground,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            )
                          )
                        ),
                        Column(
                          children: <Widget>[
                            IconButton(
                              splashRadius: 20,
                              onPressed: () => showDialog(
                                context: context,
                                builder: (_) => BlocProvider<RecipeInteractionBloc>.value(
                                  value: BlocProvider.of<RecipeInteractionBloc>(context),
                                  child: CustomAlertDialog(
                                    title: const Text("Remove Step"),
                                    content: Text("Are you sure you want to remove step ${index+1}?"),
                                    rightButtonText: "Remove",
                                    rightButtonCallback: () => context.read<RecipeInteractionBloc>().add(RemoveRecipeStep(index)),
                                  )
                                )
                              ),
                              icon: Icon(
                                Icons.delete,
                                color: Theme.of(context).colorScheme.inversePrimary)
                            ),
                            IconButton(
                                splashRadius: 20,
                                onPressed: () => Clipboard.setData(ClipboardData(text: step.text)).then((_) {
                                  ScaffoldMessenger.of(context)
                                    ..removeCurrentSnackBar()
                                    ..showSnackBar(
                                      SnackBar(
                                        content: Text("Step ${index+1} copied to clipboard",
                                          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
                                        backgroundColor: Theme.of(context).colorScheme.primary,
                                      ));
                                }),
                                icon: Icon(Icons.copy, color: Theme.of(context).colorScheme.onBackground.withAlpha(150))
                            )
                          ],
                        )
                      ],
                    )
                  ])));
          },
        );
      },
    );
  }
}
