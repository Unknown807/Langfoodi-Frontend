part of 'models.dart';

enum UsernameValidationError { invalid }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('');
  const Username.dirty([super.value = '']) : super.dirty();

  static final _userNameRegExp =
  RegExp(r"^[a-zA-Z0-9]{3,}$");

  @override
  UsernameValidationError? validator(String? value) {
    return _userNameRegExp.hasMatch(value ?? '')
        ? null
        : UsernameValidationError.invalid;
  }
}