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
      backgroundColor: const Color(0xFF189A03),
      child: Icon(icon, color: Colors.white, size: 40),
      onPressed: () => eventFunc.call(),
    );
  }
}
