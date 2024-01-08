part of 'recipe_interaction_widgets.dart';

class RecipeBackButton extends StatelessWidget {
  const RecipeBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_circle_left_outlined,
        color: Colors.indigoAccent,
        size: 30,
      ),
      onPressed: () => showDialog(
        context: context,
        builder: (_) => BlocProvider<RecipeInteractionBloc>.value(
          value: BlocProvider.of<RecipeInteractionBloc>(context),
          child: CustomAlertDialog(
            title: const Text("Go Back"),
            content: const Text("Are you sure you want to go back?"),
            rightButtonText: "Back",
            rightButtonCallback: () => context
              .read<NavigationRepository>()
              .goTo(context, "home", routeType: RouteType.backLink),
          )
        )
      ),
    );
  }
}