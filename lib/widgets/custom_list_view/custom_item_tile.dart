part of '../shared_widgets.dart';

class CustomItemTile extends StatelessWidget {
  const CustomItemTile({
    super.key,
    required this.titleText,
    required this.subtitleText,
  });

  final String titleText;
  final String? subtitleText;

  @override
  Widget build(BuildContext context) {
    var subtitleValue;
    if (subtitleText != null) {
      subtitleValue = Text(subtitleText!);
    }

    return ListTile(
        title: Text(titleText),
        subtitle: subtitleValue,
        onTap: (){},
        trailing: const Text("Edit")
    );

  }
}
