part of 'form_models.dart';

enum FormValidationError {
  handlerInvalid,
  emailInvalid,
  userNameInvalid,
  passwordInvalid,
  confirmedPasswordNoMatch;

  static Map<FormValidationError,String> errorMap = {
    FormValidationError.handlerInvalid: "Needs 3+ length & only letters/numbers/spaces or underscore",
    FormValidationError.emailInvalid: "Invalid email",
    FormValidationError.userNameInvalid: "Needs 3+ length & only letters/numbers/spaces or underscore",
    FormValidationError.passwordInvalid: "Needs 8+ length & 1 uppercase, 1 lowercase, 1 digit & 1 special",
    FormValidationError.confirmedPasswordNoMatch: "Passwords must match"
  };

  static String? getErrorMessage(FormValidationError? error) => errorMap[error];
}
