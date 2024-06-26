part of 'base_form.dart';

@immutable
class InputEvent extends Equatable {
  const InputEvent();

  @override
  List<Object?> get props => [];
}

final class HandlerChanged extends InputEvent {
  const HandlerChanged(this.handler);

  final String handler;

  @override
  List<Object> get props => [handler];
}

final class UserNameChanged extends InputEvent {
  const UserNameChanged(this.userName);

  final String userName;

  @override
  List<Object> get props => [userName];
}

final class EmailChanged extends InputEvent {
  const EmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

final class PasswordChanged extends InputEvent {
  const PasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

final class ConfirmedPasswordChanged extends InputEvent {
  const ConfirmedPasswordChanged(this.confirmedPassword);

  final String confirmedPassword;

  @override
  List<Object> get props => [confirmedPassword];
}

final class FormSubmitted extends InputEvent {
  const FormSubmitted();
}