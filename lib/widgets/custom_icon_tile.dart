part of 'shared_widgets.dart';

class CustomIconTile extends StatelessWidget {
  const CustomIconTile({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.tileColor,
    this.borderStrokeWidth = 3,
    this.borderRadius = 10,
    this.iconSize = 40,
    this.padding = const EdgeInsets.all(25),
    this.backgroundColor
  });

  final IconData icon;
  final Color iconColor;
  final Color tileColor;
  final double borderStrokeWidth;
  final double borderRadius;
  final double iconSize;
  final EdgeInsets? padding;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      strokeWidth: borderStrokeWidth,
      color: tileColor,
      borderType: BorderType.RRect,
      radius: Radius.circular(borderRadius),
      padding: padding ?? const EdgeInsets.all(2),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: backgroundColor,
        child: Center(child: Icon(icon, size: iconSize, color: iconColor))
      )
    );
  }
}