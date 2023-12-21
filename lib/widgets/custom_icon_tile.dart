part of 'shared_widgets.dart';

class CustomIconTile extends StatelessWidget {
  const CustomIconTile({
    super.key,
    required this.icon,
    required this.tileColor,
    this.borderStrokeWidth = 1.5,
    this.borderRadius = 10,
    this.iconSize = 70,
  });

  final IconData icon;
  final Color tileColor;
  final double borderStrokeWidth;
  final double borderRadius;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
        strokeWidth: borderStrokeWidth,
        color: tileColor,
        borderType: BorderType.RRect,
        radius: Radius.circular(borderRadius),
        padding: const EdgeInsets.all(25),
        child: Center(child: Icon(icon, size: iconSize, color: tileColor))
    );
  }
}