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
      child: Text(text,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: fontSize),
      ));
  }
}