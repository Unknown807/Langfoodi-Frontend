part of 'conversation_widgets.dart';

class AttachRecipeButton extends StatelessWidget {
  const AttachRecipeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationBloc, ConversationState>(
      builder: (context, state) {
        return IconButton(
          padding: const EdgeInsets.only(left: 5),
          iconSize: 22,
          splashRadius: 20,
          color: Theme.of(context).colorScheme.tertiary,
          icon: const Icon(Icons.fastfood),
          onPressed: () {
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
                  child: ListView.builder(
                    itemCount: state.currentRecipes.length,
                    itemBuilder: (context, index) {
                      final recipe = state.currentRecipes[index];
                      return Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            //Flexible(flex: 0, child: Text(recipe.thumbnailId ?? "img id")),
                            Expanded(flex: 2, child: Text(recipe.title)),
                            Flexible(flex: 0, child: Checkbox(value: false, onChanged: (value) => print(value)))
                          ],
                        )
                      );
                    },
                  )),
                  rightButtonText: "Attach",
                  rightButtonCallback: () => print("Attached"),
                )
              )
            );
          }
        );
      }
    );
  }
}