part of 'form_widgets.dart';

enum FormInputBoxDecorationType { underlined, textArea, error, underlinedError, minimal }

class FormInput extends StatelessWidget {
  FormInput({
      super.key,
      required this.eventFunc,
      this.errorText,
      this.width,
      this.height,
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

  Decoration? getBoxDecoration(ThemeData themeData, FormInputBoxDecorationType? type) {
    switch (type) {
      case FormInputBoxDecorationType.underlined:
        return BoxDecoration(
          color: themeData.colorScheme.background,
          border: Border(bottom: BorderSide(color: themeData.hintColor.withAlpha(70))));
      case FormInputBoxDecorationType.underlinedError:
        return BoxDecoration(
          color: themeData.colorScheme.background,
          border: Border(bottom: BorderSide(color: themeData.colorScheme.inversePrimary)));
      case FormInputBoxDecorationType.textArea:
        return BoxDecoration(
          color: themeData.colorScheme.background,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: themeData.hintColor.withAlpha(70)),
        );
      case FormInputBoxDecorationType.error:
        return BoxDecoration(
          color: themeData.colorScheme.background,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: themeData.colorScheme.inversePrimary));
      case FormInputBoxDecorationType.minimal:
        return BoxDecoration(
          color: themeData.colorScheme.background,
          border: Border.all(color: themeData.colorScheme.background));
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Padding(
      padding: outerPadding,
      child: Container(
        height: height,
        width: width,
        padding: innerPadding,
        decoration: getBoxDecoration(themeData, boxDecorationType),
        child: TextField(
          cursorColor: themeData.colorScheme.tertiary,
          readOnly: readonly,
          keyboardType: keyboardType,
          controller: textController,
          onSubmitted: (value) => onSubmittedEventFunc == null ? null : onSubmittedEventFunc!(value),
          textInputAction: TextInputAction.done,
          maxLines: maxLines,
          textAlign: textAlign,
          obscureText: isConfidential,
          onChanged: (value) => eventFunc(value),
          style: TextStyle(
            color: themeData.colorScheme.onBackground,
            fontWeight: fontWeight,
            fontSize: fontSize),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            labelText: labelText,
            errorText: errorText,
            hintStyle: TextStyle(color: themeData.hintColor),
            labelStyle: TextStyle(color: themeData.hintColor),
            floatingLabelStyle: TextStyle(color: themeData.colorScheme.tertiary)),
        )));
  }
}
