part of 'form_models.dart';

class Username extends FormzInput<String, FormValidationError> {
  const Username.pure() : super.pure('');
  const Username.dirty([super.value = '']) : super.dirty();

  static final _userNameExp = RegExp(
      r"^[a-zA-Z0-9_]+[a-zA-Z0-9_ ]{2,}$"
  );

  @override
  FormValidationError? validator(String? value) {
    return _userNameExp.hasMatch(value ?? '')
        ? null
        : FormValidationError.userNameInvalid;
  }
}