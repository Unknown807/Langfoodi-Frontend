part of 'profile_settings_widgets.dart';

class ReadonlyProfileTile extends StatelessWidget {
  const ReadonlyProfileTile({
    super.key,
    required this.titleText,
    required this.subtitleText,
    required this.eventFunc,
    this.editable = true,
  });

  final String titleText;
  final String subtitleText;
  final VoidCallback eventFunc;
  final bool editable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: ListTile(
        visualDensity: VisualDensity.standard,
        title: Text(
          titleText,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Theme.of(context).colorScheme.tertiary,
            fontSize: 14
          ),
        ),
        subtitle: Text(
          subtitleText,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontSize: 18
          ),
        ),
        trailing: editable
          ? CustomTextButton(
              text: "Edit",
              eventFunc: eventFunc,
            )
          : const SizedBox.shrink()
      ),
    );
  }
}