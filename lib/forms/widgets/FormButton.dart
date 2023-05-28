import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  const FormButton({
    super.key,
    required this.eventFunc,
    required this.btnText,
    this.bgColor = const Color.fromRGBO(148, 152, 251, 1),
    this.fgColor = Colors.white
  });

  final String btnText;
  final Color bgColor;
  final Color fgColor;
  final VoidCallback? eventFunc;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: bgColor,
        foregroundColor: fgColor
      ),
      onPressed: eventFunc,
      child: Text(btnText),
    );
  }
}