part of 'recipe_interaction_widgets.dart';

class RecipeBackButton extends StatelessWidget {
  const RecipeBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_rounded,
        color: Theme.of(context).colorScheme.tertiary,
        size: 30,
      ),
      onPressed: () {
        final bloc = BlocProvider.of<RecipeInteractionBloc>(context);
        if (bloc.state.pageType == RecipeInteractionType.readonly) {
          context
            .read<NavigationRepository>()
            .goTo(context, "home", routeType: RouteType.backLink);
        } else {
          showDialog(
            context: context,
            builder: (_) => BlocProvider<RecipeInteractionBloc>.value(
              value: bloc,
              child: CustomAlertDialog(
                title: const Text("Go Back"),
                content: const Text("Are you sure you want to go back?"),
                rightButtonText: "Back",
                rightButtonCallback: () => context
                  .read<NavigationRepository>()
                  .goTo(context, "home", routeType: RouteType.backLink),
              )
            )
          );
        }
      }
    );
  }
}