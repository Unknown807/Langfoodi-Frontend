part of 'conversation_widgets.dart';

class AttachRecipeButton extends StatelessWidget {
  const AttachRecipeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.only(left: 5),
      iconSize: 22,
      splashRadius: 20,
      color: Theme.of(context).colorScheme.tertiary,
      icon: const Icon(Icons.fastfood),
      onPressed: () {},
    );
  }
}