part of 'profile_settings_widgets.dart';

class EditFieldCancelButton extends StatelessWidget {
  const EditFieldCancelButton({
    super.key,
    required this.onPressed
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 30,
      splashRadius: 20,
      icon: const Icon(Icons.cancel_rounded),
      color: Theme.of(context).colorScheme.inversePrimary,
      onPressed: onPressed
    );
  }
}