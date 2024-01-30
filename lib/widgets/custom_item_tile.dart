part of 'shared_widgets.dart';

class CustomItemTile extends StatelessWidget {
  const CustomItemTile({
    super.key,
    required this.titleWidget,
    this.subtitleWidget,
    this.trailingWidget,
    this.tapFunc
  });

  final Widget titleWidget;
  final Widget? subtitleWidget;
  final Widget? trailingWidget;
  final Function? tapFunc;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: titleWidget,
      subtitle: subtitleWidget,
      onTap: tapFunc?.call(),
      trailing: trailingWidget
    );

  }
}
