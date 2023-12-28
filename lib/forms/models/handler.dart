part of 'form_models.dart';

class Handler extends FormzInput<String, FormValidationError> {
  const Handler.pure() : super.pure("");
  const Handler.dirty([super.value = ""]) : super.dirty();

  static final _handlerExp = RegExp(
      r"^[a-zA-Z0-9_]+[a-zA-Z0-9_ ]{2,}$"
  );

  @override
  FormValidationError? validator(String? value) {
    return _handlerExp.hasMatch(value ?? "")
        ? null
        : FormValidationError.handlerInvalid;
  }
}