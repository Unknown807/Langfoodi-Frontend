part of 'form_widgets.dart';

class FormInput extends StatelessWidget {
  FormInput(
      {super.key,
      this.errorText,
      required this.hint,
      required this.eventFunc,
      this.useBorderStyle = true,
      this.isConfidential = false});

  String? errorText;
  bool isConfidential;
  bool useBorderStyle;
  final String hint;
  final Function eventFunc;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8.0),
        decoration: useBorderStyle
            ? BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade100)))
            : null,
        child: TextField(
          obscureText: isConfidential,
          onChanged: (value) => eventFunc(value),
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              errorText: errorText,
              hintStyle: TextStyle(color: Colors.grey.shade400)),
        ));
  }
}
