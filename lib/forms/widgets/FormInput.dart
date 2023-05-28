import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  FormInput({
    super.key,
    required this.errTxt,
    required this.hintTxt,
    required this.eventFunc,
    this.useBorderStyle = true,
    this.isConfidential = false
  });

  String? errTxt;
  bool isConfidential;
  bool useBorderStyle;
  final String hintTxt;
  final Function eventFunc;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8.0),
        decoration: !useBorderStyle
            ? null
            : BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.grey.shade100))),
        child: TextField(
          obscureText: isConfidential,
          onChanged: (value) => eventFunc(value),
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintTxt,
              errorText: errTxt,
              hintStyle: TextStyle(color: Colors.grey.shade400)),
        ));
  }
}
