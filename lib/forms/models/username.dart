part of 'models.dart';

class Username extends FormzInput<String, FormValidationError> {
  const Username.pure() : super.pure('');
  const Username.dirty([super.value = '']) : super.dirty();

  static final _userNameRegExp =
  RegExp(r"^[a-zA-Z0-9]{3,}$");

  @override
  FormValidationError? validator(String? value) {
    return _userNameRegExp.hasMatch(value ?? '')
        ? null
        : FormValidationError.userNameInvalid;
  }
}