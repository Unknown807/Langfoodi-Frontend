part of 'login_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, InputState>(
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
                UserNameEmailInput(),
                PasswordInput(),
              ])),
          const SizedBox(height: 5),
          Row(
            children: <Widget>[
              const Spacer(),
              CustomTextButton(eventFunc: () {}, text: "Forgot Password?"),
            ],
          ),
          const LoginButton(),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text("Don't have an account?    ",
                  style: TextStyle(
                    color: Color.fromRGBO(143, 148, 251, 1),
                  )),
              CustomTextButton(
                  eventFunc: () { context.read<NavigationRepository>().goTo(context, "/register"); },
                  text: "Sign Up",
                  fontSize: 16),
            ],
          ),
        ]));
  }
}

class FormErrorLabel extends StatelessWidget {
  const FormErrorLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, InputState>(
      buildWhen: (p, c) => p.errorMessage != c.errorMessage,
      builder: (context, state) {
        return Text(state.errorMessage,
            style: const TextStyle(
              color: Color.fromRGBO(244, 113, 116, 1),
            ));
      },
    );
  }
}

class UserNameEmailInput extends StatelessWidget {
  const UserNameEmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, InputState>(
      buildWhen: (p, c) => p.email != c.email || p.userName != c.userName,
      builder: (context, state) {
        return FormInput(
            boxDecorationType: FormInputBoxDecorationType.underlined,
            hint: "Username or Email",
            eventFunc: (value) {
              context.read<LoginBloc>().add(EmailChanged(value));
              context.read<LoginBloc>().add(UserNameChanged(value));
            });
      },
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, InputState>(
      buildWhen: (p, c) => p.password != c.password,
      builder: (context, state) {
        return FormInput(
          isConfidential: true,
          hint: "Password",
          eventFunc: (password) {
            context.read<LoginBloc>().add(PasswordChanged(password));
          },
        );
      },
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, InputState>(
      builder: (context, state) {
        if (state.formStatus.isInProgress) {
          return const CircularProgressIndicator();
        }

        bool allFieldsValid =
            (state.userNameValid || state.emailValid) && state.passwordValid;

        return FormButton(
          eventFunc: allFieldsValid
              ? () => context.read<LoginBloc>().add(const FormSubmitted())
              : null,
          text: "Login",
        );
      },
    );
  }
}
