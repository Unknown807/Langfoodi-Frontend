part of 'models.dart';

class Password extends FormzInput<String, FormValidationError> {
  const Password.pure() : super.pure('');

  const Password.dirty([super.value = '']) : super.dirty();

  static final _passwordRegExp =
      RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$");

  @override
  FormValidationError? validator(String? value) {
    return _passwordRegExp.hasMatch(value ?? '')
        ? null
        : FormValidationError.registerPasswordInvalid;
  }
}
