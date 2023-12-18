part of 'recipe_interaction_widgets.dart';

class BackButton extends StatelessWidget {
  const BackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_circle_left_outlined,
        color: Colors.indigoAccent,
        size: 30,
      ),
      onPressed: () => context.read<NavigationRepository>().goTo(context, "home", routeType: RouteType.backLink),
    );
  }
}