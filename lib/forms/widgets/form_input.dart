part of 'form_widgets.dart';

class FormInput extends StatelessWidget {
  FormInput(
      {super.key,
      this.errorText,
      this.width,
      this.textColor,
      this.fontWeight,
      this.fontSize,
      required this.hint,
      required this.eventFunc,
      this.useBorderStyle = true,
      this.isConfidential = false,
      this.textAlign = TextAlign.left});

  String? errorText;
  double? width;
  Color? textColor;
  FontWeight? fontWeight;
  double? fontSize;
  bool isConfidential;
  bool useBorderStyle;
  TextAlign textAlign;
  final String hint;
  final Function eventFunc;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        padding: const EdgeInsets.all(8.0),
        decoration: useBorderStyle
            ? BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade100)))
            : null,
        child: TextField(
          textAlign: textAlign,
          obscureText: isConfidential,
          onChanged: (value) => eventFunc(value),
          style: TextStyle(
              color: textColor,
              fontWeight: fontWeight,
              fontSize: fontSize
          ),
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              errorText: errorText,
              hintStyle: TextStyle(color: Colors.grey.shade400)),
        ));
  }
}
