part of 'register_bloc.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, InputState>(
      listener: (context, state) {
        if (state.formStatus.isSuccess) {
          context.read<NavigationRepository>().goTo(context, "/home", routeType: RouteType.onlyThis);
        }
      },
      child: Column(children: <Widget>[
        const FormErrorLabel(),
        const SizedBox(height: 5),
        Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromRGBO(143, 148, 251, .2),
                      blurRadius: 20.0,
                      offset: Offset(0, 10))
                ]),
            child: const Column(children: <Widget>[
              UserNameInput(),
              EmailInput(),
              PasswordInput(),
              ConfirmPasswordInput(),
            ])),
        const SizedBox(height: 20),
        const RegisterButton()
      ]),
    );
  }
}

class FormErrorLabel extends StatelessWidget {
  const FormErrorLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, InputState>(
      buildWhen: (p, c) => p.errorMessage != c.errorMessage,
      builder: (context, state) {
        return Text(state.errorMessage ?? "",
            style: const TextStyle(
              color: Color.fromRGBO(244, 113, 116, 1),
            ));
      },
    );
  }
}

class UserNameInput extends StatelessWidget {
  const UserNameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, InputState>(
      buildWhen: (p, c) => p.userName != c.userName,
      builder: (context, state) {
        return FormInput(
            boxDecorationType: FormInputBoxDecorationType.underlined,
            errorText: FormValidationError.getErrorMessage(state.userName.displayError),
            hint: "Username",
            eventFunc: (userName) {
              context.read<RegisterBloc>().add(UserNameChanged(userName));
            });
      },
    );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, InputState>(
      buildWhen: (p, c) => p.email != c.email,
      builder: (context, state) {
        return FormInput(
            boxDecorationType: FormInputBoxDecorationType.underlined,
            errorText: FormValidationError.getErrorMessage(state.email.displayError),
            hint: "Email",
            eventFunc: (email) {
              context.read<RegisterBloc>().add(EmailChanged(email));
            });
      },
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, InputState>(
      buildWhen: (p, c) => p.password != c.password,
      builder: (context, state) {
        return FormInput(
          boxDecorationType: FormInputBoxDecorationType.underlined,
          isConfidential: true,
          errorText: FormValidationError.getErrorMessage(state.password.displayError),
          hint: "Password",
          eventFunc: (password) {
            context.read<RegisterBloc>().add(PasswordChanged(password));
          },
        );
      },
    );
  }
}

class ConfirmPasswordInput extends StatelessWidget {
  const ConfirmPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, InputState>(
      buildWhen: (p, c) =>
          p.password != c.password ||
          p.confirmedPassword != c.confirmedPassword,
      builder: (context, state) {
        return FormInput(
          isConfidential: true,
          errorText: FormValidationError.getErrorMessage(state.confirmedPassword.displayError),
          hint: "Confirm Password",
          eventFunc: (confirmedPassword) {
            context
                .read<RegisterBloc>()
                .add(ConfirmedPasswordChanged(confirmedPassword));
          },
        );
      },
    );
  }
}

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, InputState>(
      builder: (context, state) {
        if (state.formStatus.isInProgress) {
          return const CircularProgressIndicator();
        }

        bool allFieldsValid =
            state.userNameValid &&
            state.emailValid &&
            state.passwordValid &&
            state.confirmedPasswordValid;
        return FormButton(
          eventFunc: allFieldsValid
              ? () => context.read<RegisterBloc>().add(const FormSubmitted())
              : null,
          text: "Sign Up",
        );
      },
    );
  }
}
