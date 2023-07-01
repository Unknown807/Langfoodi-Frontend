part of 'models.dart';

class Password extends FormzInput<String, FormValidationError> {
  const Password.pure() : super.pure('');

  const Password.dirty([super.value = '']) : super.dirty();

  static final _passwordExp =
      RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$");

  @override
  FormValidationError? validator(String? value) {
    return _passwordExp.hasMatch(value ?? '')
        ? null
        : FormValidationError.passwordInvalid;
  }
}
