part of 'conversation_widgets.dart';

class AttachRecipeButton extends StatelessWidget {
  const AttachRecipeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationBloc, ConversationState>(
      buildWhen: (p, c) =>
        p.currentRecipes != c.currentRecipes
        || p.pageLoading != c.pageLoading
        || p.allowRecipes != c.allowRecipes
        || p.sendingMessage != c.sendingMessage,
      builder: (context, state) {
        return IconButton(
          padding: const EdgeInsets.only(left: 5),
          iconSize: 22,
          splashRadius: 20,
          disabledColor: Theme.of(context).hintColor,
          color: Theme.of(context).colorScheme.tertiary,
          icon: const Icon(Icons.fastfood),
          onPressed: state.currentRecipes.isEmpty
            || !state.allowRecipes
            || state.sendingMessage
            || state.pageLoading
            || state.isBlocked
              ? null
              : () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) => BlocProvider<ConversationBloc>.value(
                    value: BlocProvider.of<ConversationBloc>(context),
                    child: CustomAlertDialog(
                      title: const Text("Attach Recipes"),
                      content: SizedBox(
                        height: 150,
                        width: 300,
                        child: state.pageLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ScrollConfiguration(
                              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                              child: ListView.separated(
                                itemCount: state.currentRecipes.length,
                                separatorBuilder: (context, state) => const SizedBox(height: 10),
                                itemBuilder: (context, index) {
                                  final recipe = state.currentRecipes[index];
                                  final noImage = recipe.thumbnailId?.isEmpty ?? true;
                                  return Row(
                                    children: [
                                      SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(5),
                                          child: context.read<ImageBuilder>().decideOnAndDisplayImage(
                                            isAsset: true,
                                            imageUrl: noImage ? "assets/images/no_image.png" : recipe.thumbnailId!,
                                            transformationType: ImageTransformationType.tiny,
                                            errorBuilder: (context, obj1, obj2) {
                                              return CustomIconTile(
                                                padding: null,
                                                icon: Icons.error,
                                                backgroundColor: Theme.of(context).colorScheme.surface,
                                                iconColor: Theme.of(context).colorScheme.error,
                                                tileColor: Theme.of(context).colorScheme.error,
                                              );
                                            },
                                          ),
                                        )
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Text(
                                            recipe.title,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Theme.of(context).colorScheme.onSurface
                                            ),
                                          ))
                                      ),
                                      BlocBuilder<ConversationBloc, ConversationState>(
                                        buildWhen: (p, c) => p.checkboxValues[index] != c.checkboxValues[index],
                                        builder: (context, state) {
                                          return Checkbox(
                                            value: state.checkboxValues[index],
                                            onChanged: (value) => context
                                              .read<ConversationBloc>()
                                              .add(SetCheckboxValue(index, value!))
                                          );
                                        },
                                      )
                                    ],
                                  );
                                },
                              )
                        )
                      ),
                      leftButtonCallback: () => context
                        .read<ConversationBloc>()
                        .add(const CancelRecipeAttachment()),
                      rightButtonText: "Select",
                      rightButtonCallback: () => context
                        .read<ConversationBloc>()
                        .add(const AttachRecipes())
                    )
                  )
                );
              }
        );
      }
    );
  }
}