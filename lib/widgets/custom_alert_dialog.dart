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
                style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.blueAccent)),
                child: Text(leftButtonText!),
        ),
        TextButton(
            onPressed: () {
              rightButtonCallback?.call();
              context.read<NavigationRepository>().dismissDialog(context);
            },
            style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.blueAccent)),
            child: Text(rightButtonText))
      ],
    );
  }
}