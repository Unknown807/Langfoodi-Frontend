part of 'form_widgets.dart';

enum FormInputBoxDecorationType {
  underlined,
  fullBorder
}

class FormInput extends StatelessWidget {
  FormInput(
      {super.key,
      this.errorText,
      this.width,
      this.textColor,
      this.fontWeight,
      this.fontSize,
      this.boxDecorationType,
      required this.hint,
      required this.eventFunc,
      this.isConfidential = false,
      this.textAlign = TextAlign.left,
      this.maxLines = 1});

  String? errorText;
  double? width;
  Color? textColor;
  FontWeight? fontWeight;
  double? fontSize;
  FormInputBoxDecorationType? boxDecorationType;
  bool isConfidential;
  int maxLines;
  TextAlign textAlign;
  final String hint;
  final Function eventFunc;

  Decoration? getBoxDecoration(FormInputBoxDecorationType? type) {
    switch (type) {
      case FormInputBoxDecorationType.underlined:
        return BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade100)));
      case FormInputBoxDecorationType.fullBorder:
        return BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border(
              top: BorderSide(color: Colors.grey.shade200),
              bottom: BorderSide(color: Colors.grey.shade200),
              right: BorderSide(color: Colors.grey.shade200),
              left: BorderSide(color: Colors.grey.shade200)
            ));
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        padding: const EdgeInsets.all(8.0),
        decoration: getBoxDecoration(boxDecorationType),
        child: TextField(
          maxLines: maxLines,
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
