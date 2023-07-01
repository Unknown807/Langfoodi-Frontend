part of 'models.dart';

class ConfirmedPassword extends FormzInput<String, FormValidationError> {
  const ConfirmedPassword.pure({this.password = ''}) : super.pure('');
  const ConfirmedPassword.dirty({required this.password, String value = ''})
      : super.dirty(value);

  final String password;

  @override
  FormValidationError? validator(String? value) {
    return password == value ? null : FormValidationError.confirmedPasswordNoMatch;
  }
}
