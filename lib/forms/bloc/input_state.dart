part of 'base_form.dart';

class InputState extends Equatable {
  const InputState({
    required this.emailTextController,
    required this.passwordTextController,
    this.handler = const Handler.pure(),
    this.userName = const Username.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.formStatus = FormzSubmissionStatus.initial,
    this.handlerValid = false,
    this.userNameValid = false,
    this.emailValid = false,
    this.passwordValid = false,
    this.confirmedPasswordValid = false,
    this.errorMessage = "",
  });

  final TextEditingController emailTextController;
  final TextEditingController passwordTextController;
  final Handler handler;
  final Username userName;
  final Email email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final FormzSubmissionStatus formStatus;
  final bool handlerValid;
  final bool userNameValid;
  final bool emailValid;
  final bool passwordValid;
  final bool confirmedPasswordValid;
  final String errorMessage;

  @override
  List<Object?> get props => [
    emailTextController,
    passwordTextController,
    handler,
    userName,
    email,
    password,
    confirmedPassword,
    formStatus,
    handlerValid,
    userNameValid,
    emailValid,
    passwordValid,
    confirmedPasswordValid,
    errorMessage,
  ];

  InputState copyWith({
    TextEditingController? emailTextController,
    TextEditingController? passwordTextController,
    Handler? handler,
    Username? userName,
    Email? email,
    Password? password,
    ConfirmedPassword? confirmedPassword,
    FormzSubmissionStatus? formStatus,
    bool? handlerValid,
    bool? userNameValid,
    bool? emailValid,
    bool? passwordValid,
    bool? confirmedPasswordValid,
    String? errorMessage,
  }) {
    return InputState(
      emailTextController: emailTextController ?? this.emailTextController,
      passwordTextController: passwordTextController ?? this.passwordTextController,
      handler: handler ?? this.handler,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      formStatus: formStatus ?? this.formStatus,
      handlerValid: handlerValid ?? this.handlerValid,
      userNameValid: userNameValid ?? this.userNameValid,
      emailValid: emailValid ?? this.emailValid,
      passwordValid: passwordValid ?? this.passwordValid,
      confirmedPasswordValid: confirmedPasswordValid ?? this.confirmedPasswordValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}