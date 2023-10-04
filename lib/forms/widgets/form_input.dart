part of 'form_widgets.dart';

enum FormInputBoxDecorationType {
  underlined,
  textArea
}

class FormInput extends StatelessWidget {
  FormInput(
      {super.key,
      this.errorText,
      this.width,
      this.height,
      this.textColor,
      this.fontWeight,
      this.fontSize,
      this.boxDecorationType,
      this.onSubmittedEventFunc,
      required this.hint,
      required this.eventFunc,
      this.isConfidential = false,
      this.textAlign = TextAlign.left,
      this.maxLines = 1,
      this.innerPadding = const EdgeInsets.all(8.0),
      this.outerPadding = const EdgeInsets.all(0.0)});

  String? errorText;
  double? width;
  double? height;
  Color? textColor;
  FontWeight? fontWeight;
  double? fontSize;
  FormInputBoxDecorationType? boxDecorationType;
  Function? onSubmittedEventFunc;
  bool isConfidential;
  int maxLines;
  EdgeInsets innerPadding;
  EdgeInsets outerPadding;
  TextAlign textAlign;
  final String hint;
  final Function eventFunc;

  Decoration? getBoxDecoration(FormInputBoxDecorationType? type) {
    switch (type) {
      case FormInputBoxDecorationType.underlined:
        return BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade100)));
      case FormInputBoxDecorationType.textArea:
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
    return Padding(
        padding: outerPadding,
        child: Container(
        height: height,
        width: width,
        padding: innerPadding,
        decoration: getBoxDecoration(boxDecorationType),
        child: TextField(
          onSubmitted: (value) => onSubmittedEventFunc == null ? null : onSubmittedEventFunc!(value),
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
        )));
  }
}
