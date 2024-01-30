part of 'profile_settings_widgets.dart';

class ReadonlyProfileTile extends StatelessWidget {
  const ReadonlyProfileTile({
    super.key,
    required this.titleText,
    required this.subtitleText,
    required this.eventFunc
  });

  final String titleText;
  final String subtitleText;
  final VoidCallback eventFunc;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        titleText,
        style: TextStyle(
          color: Theme.of(context).colorScheme.tertiary,
          fontSize: 14
        ),
      ),
      subtitle: Text(
        subtitleText,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
          fontSize: 18
        ),
      ),
      trailing: CustomTextButton(
        text: "Edit",
        eventFunc: eventFunc,
      ),
    );
  }
}