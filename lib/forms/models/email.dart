part of 'models.dart';

class Email extends FormzInput<String, FormValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([super.value = '']) : super.dirty();

  static final RegExp _emailRegExp = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)+$",
  );

  @override
  FormValidationError? validator(String? value) {
    return _emailRegExp.hasMatch(value ?? '')
        ? null
        : FormValidationError.registerEmailInvalid;
  }
}
