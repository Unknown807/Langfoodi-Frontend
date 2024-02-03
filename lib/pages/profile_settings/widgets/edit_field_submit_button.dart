part of 'profile_settings_widgets.dart';

class EditFieldSubmitButton extends StatelessWidget {
  const EditFieldSubmitButton({
    super.key,
    required this.onPressed
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 30,
      splashRadius: 20,
      icon: const Icon(Icons.check_circle),
      color: Theme.of(context).colorScheme.primary,
      onPressed: onPressed,
    );
  }

}