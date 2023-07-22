part of 'base_form.dart';

class InputState extends Equatable {
  const InputState({
    this.userName = const Username.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.formStatus = FormzSubmissionStatus.initial,
    this.userNameValid = false,
    this.emailValid = false,
    this.passwordValid = false,
    this.confirmedPasswordValid = false,
    this.errorMessage,
  });

  final Username userName;
  final Email email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final FormzSubmissionStatus formStatus;
  final bool userNameValid;
  final bool emailValid;
  final bool passwordValid;
  final bool confirmedPasswordValid;
  final String? errorMessage;

  @override
  List<Object?> get props => [
    userName,
    email,
    password,
    confirmedPassword,
    formStatus,
    userNameValid,
    emailValid,
    passwordValid,
    confirmedPasswordValid,
    errorMessage,
  ];

  InputState copyWith({
    Username? userName,
    Email? email,
    Password? password,
    ConfirmedPassword? confirmedPassword,
    FormzSubmissionStatus? formStatus,
    bool? userNameValid,
    bool? emailValid,
    bool? passwordValid,
    bool? confirmedPasswordValid,
    String? errorMessage,
  }) {
    return InputState(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      formStatus: formStatus ?? this.formStatus,
      userNameValid: userNameValid ?? this.userNameValid,
      emailValid: emailValid ?? this.emailValid,
      passwordValid: passwordValid ?? this.passwordValid,
      confirmedPasswordValid: confirmedPasswordValid ?? this.confirmedPasswordValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}