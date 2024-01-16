part of 'form_widgets.dart';

enum FormInputBoxDecorationType { underlined, textArea, error, underlinedError, minimal }

class FormInput extends StatelessWidget {
  FormInput({
      super.key,
      required this.eventFunc,
      this.errorText,
      this.width,
      this.height,
      this.textColor,
      this.fontWeight,
      this.fontSize,
      this.boxDecorationType,
      this.onSubmittedEventFunc,
      this.textController,
      this.keyboardType,
      this.hintText,
      this.labelText,
      this.readonly = false,
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
  TextEditingController? textController;
  TextInputType? keyboardType;
  String? hintText;
  String? labelText;
  bool readonly;
  bool isConfidential;
  int maxLines;
  EdgeInsets innerPadding;
  EdgeInsets outerPadding;
  TextAlign textAlign;
  final Function eventFunc;

  Decoration? getBoxDecoration(FormInputBoxDecorationType? type) {
    switch (type) {
      case FormInputBoxDecorationType.underlined:
        return BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade100)));
      case FormInputBoxDecorationType.underlinedError:
        return const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.redAccent)));
      case FormInputBoxDecorationType.textArea:
        return BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey.shade200));
      case FormInputBoxDecorationType.error:
        return BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.redAccent));
      case FormInputBoxDecorationType.minimal:
        return BoxDecoration(border: Border.all(color: Colors.white));
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
              readOnly: readonly,
              keyboardType: keyboardType,
              controller: textController,
              onSubmitted: (value) => onSubmittedEventFunc == null ? null : onSubmittedEventFunc!(value),
              textInputAction: TextInputAction.done,
              maxLines: maxLines,
              textAlign: textAlign,
              obscureText: isConfidential,
              onChanged: (value) => eventFunc(value),
              style: TextStyle(color: textColor, fontWeight: fontWeight, fontSize: fontSize),
              decoration: InputDecoration(
                //focusColor: Colors.red,
                border: InputBorder.none,
                hintText: hintText,
                labelText: labelText,
                errorText: errorText,
                hintStyle: TextStyle(color: Colors.grey.shade400),
                labelStyle: TextStyle(color: Colors.grey.shade400),
                floatingLabelStyle: const TextStyle(color: Colors.blue)),
            )));
  }
}
