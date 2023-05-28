import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:recipe_social_media/forms/models/username.dart';
import 'models/confirmed_password.dart';
import 'models/email.dart';
import 'models/password.dart';

final class InputState extends Equatable {
  const InputState({
    this.userName = const Username.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.status = FormzSubmissionStatus.initial,
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
  final FormzSubmissionStatus status;
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
    status,
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
    FormzSubmissionStatus? status,
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
      status: status ?? this.status,
      userNameValid: userNameValid ?? this.userNameValid,
      emailValid: emailValid ?? this.emailValid,
      passwordValid: passwordValid ?? this.passwordValid,
      confirmedPasswordValid: confirmedPasswordValid ?? this.confirmedPasswordValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}