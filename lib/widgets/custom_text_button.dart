part of 'shared_widgets.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.eventFunc,
    required this.text,
    this.fontSize = 16
  });

  final double fontSize;
  final String text;
  final VoidCallback? eventFunc;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: eventFunc,
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.hovered)) {
            return Theme.of(context).colorScheme.secondary.withAlpha(30);
          }
          else if (states.contains(MaterialState.pressed)) {
            return Theme.of(context).colorScheme.secondary;
          }
        })
      ),
      child: Text(text,
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontSize: fontSize),
      ));
  }
}