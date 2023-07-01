part of 'models.dart';

enum FormValidationError {
  emailInvalid,
  registerUserNameInvalid,
  registerPasswordInvalid,
  registerConfirmedPasswordNoMatch;

  static Map<FormValidationError,String> errorMap = {
    FormValidationError.emailInvalid: "Invalid email",
    FormValidationError.registerUserNameInvalid: "Needs 3+ length & only letters/numbers",
    FormValidationError.registerPasswordInvalid: "Needs 8+ length & 1 uppercase, 1 lowercase, 1 digit & 1 special",
    FormValidationError.registerConfirmedPasswordNoMatch: "Passwords must match"
  };

  static String? getErrorMessage(FormValidationError? error) => errorMap[error];
}
