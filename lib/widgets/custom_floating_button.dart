part of 'shared_widgets.dart';

class CustomFloatingButton extends StatelessWidget {
  const CustomFloatingButton({
    super.key,
    required this.eventFunc,
    required this.icon
  });

  final IconData icon;
  final VoidCallback eventFunc;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: key,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100.0), // Adjust the radius
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Icon(icon, color: Theme.of(context).colorScheme.onPrimary, size: 40),
      onPressed: () => eventFunc.call(),
    );
  }
}
