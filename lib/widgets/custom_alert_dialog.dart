part of 'shared_widgets.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    this.content,
    this.title,
    this.leftButtonCallback,
    this.rightButtonCallback,
    this.leftButtonText = "Cancel",
    this.rightButtonText = "Ok"
  });

  final Widget? title;
  final Widget? content;
  final String? leftButtonText;
  final String rightButtonText;
  final VoidCallback? leftButtonCallback;
  final VoidCallback? rightButtonCallback;

  @override
  Widget build(BuildContext context) {
    final btnStyle = ButtonStyle(
      overlayColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.hovered)) {
          return Theme.of(context).colorScheme.secondary.withAlpha(30);
        }
        else if (states.contains(MaterialState.pressed)) {
          return Theme.of(context).colorScheme.secondary;
        }
      }),
      foregroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.secondary));

    return AlertDialog(
      title: title,
      content: content,
      actions: [
        leftButtonText == null
            ? const SizedBox()
            : TextButton(
                onPressed: () {
                  leftButtonCallback?.call();
                  context.read<NavigationRepository>().dismissDialog(context);
                },
                style: btnStyle,
                child: Text(leftButtonText!),
        ),
        TextButton(
            onPressed: () {
              rightButtonCallback?.call();
              context.read<NavigationRepository>().dismissDialog(context);
            },
            style: btnStyle,
            child: Text(rightButtonText))
      ],
    );
  }
}