part of 'base_form.dart';

class FormBloc extends Bloc<InputEvent, InputState> {
  FormBloc() : super(const InputState()) {
    on<UserNameChanged>(_onUserNameChanged);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_passwordChanged);
    on<ConfirmedPasswordChanged>(_confirmedPasswordChanged);
    on<FormSubmitted>(formSubmitted);
  }

  void _onUserNameChanged(UserNameChanged event, Emitter<InputState> emit) {
    final userName = Username.dirty(event.userName);
    emit(
        state.copyWith(
          userName: userName,
          userNameValid: Formz.validate([userName])
        )
    );
  }

  void _onEmailChanged(EmailChanged event, Emitter<InputState> emit) {
    final email = Email.dirty(event.email);
    emit(
        state.copyWith(
            email: email,
            emailValid: Formz.validate([email])
        )
    );
  }

  void _passwordChanged(PasswordChanged event, Emitter<InputState> emit) {
    final password = Password.dirty(event.password);
    final confirmedPassword = ConfirmedPassword.dirty(
      password: password.value,
      value: state.confirmedPassword.value,
    );
    emit(
      state.copyWith(
        password: password,
        confirmedPassword: confirmedPassword,
        passwordValid: Formz.validate([password]),
        confirmedPasswordValid: Formz.validate([confirmedPassword])
      ),
    );
  }

  void _confirmedPasswordChanged(ConfirmedPasswordChanged event, Emitter<InputState> emit) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: event.confirmedPassword,
    );
    emit(
      state.copyWith(
        confirmedPassword: confirmedPassword,
        confirmedPasswordValid: Formz.validate([confirmedPassword]),
      ),
    );
  }

  Future<void> formSubmitted(FormSubmitted event, Emitter<InputState> emit) async {}
}
