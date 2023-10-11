part of 'shared_widgets.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.eventFunc,
    required this.text,
    this.overlayColor = const Color.fromRGBO(143, 148, 251, .5),
    this.textColor = const Color.fromRGBO(105, 110, 253, 1),
    this.fontSize = 14
  });

  final double fontSize;
  final String text;
  final Color overlayColor;
  final Color textColor;
  final VoidCallback? eventFunc;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: eventFunc,
        style: ButtonStyle(overlayColor: MaterialStateProperty.all(overlayColor)),
        child: Text(
          text,
          style: TextStyle(
              color: textColor, fontSize: fontSize),
        ));
  }
}