part of 'shared_widgets.dart';

class CustomExpansionTile extends StatelessWidget {
  CustomExpansionTile({
    super.key,
    required this.title,
    this.subtitle,
    this.iconPosition = ListTileControlAffinity.leading,
    this.children = const [],
    this.dividerColor = Colors.transparent,
    this.backgroundColor = Colors.transparent,
    this.collapsedBackgroundColor = Colors.transparent,
    this.iconColor = Colors.black54,
    this.collapsedIconColor = Colors.black54
  });

  final Widget? subtitle;
  final Widget title;
  final ListTileControlAffinity iconPosition;
  final List<Widget> children;
  Color dividerColor;
  Color backgroundColor;
  Color collapsedBackgroundColor;
  Color iconColor;
  Color collapsedIconColor;

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          dividerColor: dividerColor,
          expansionTileTheme: ExpansionTileThemeData(
              backgroundColor: backgroundColor,
              collapsedBackgroundColor: collapsedBackgroundColor,
              iconColor: iconColor,
              collapsedIconColor: collapsedIconColor
          ),
        ),
        child: ExpansionTile(
          title: title,
          subtitle: subtitle,
          controlAffinity: ListTileControlAffinity.leading,
          children: children,
        ));
  }
}