part of 'login_bloc.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, InputState>(
        listener: (context, state) {
          if (state.formStatus.isSuccess) {
            context.read<NavigationRepository>().goTo(context, "/home", routeType: RouteType.onlyThis);
          }
        },
        child: Container(child:Expanded(child:Column(children: <Widget>[
          Column(children: <Widget>[
            HandlerEmailInput(controller: emailController),
            PasswordInput(controller: passwordController),
          ]),
          const FormErrorLabel(),
          const SizedBox(height: 10),
          const LoginButton(),
          const SizedBox(height: 10),
          Row(children:[Expanded(child:Container(child: OutlinedButton(
            onPressed: () {context
                .read<NavigationRepository>()
                .goTo(context, "/register");
            },

            style: OutlinedButton.styleFrom(side:const BorderSide(color: Colors.green)),

            child: const Text("Create account"),
          )))]),
        ]))));
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
          style: TextStyle(color: Theme.of(context).colorScheme.error));
      },
    );
  }
}

class HandlerEmailInput extends StatelessWidget {
  const HandlerEmailInput({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, InputState>(
      buildWhen: (p, c) => p.email != c.email,
      builder: (context, state) {
        return (FormInput(
          hintText: "Email",
          eventFunc: (value) {
            context.read<LoginBloc>().add(EmailChanged(value));
          },
        height: 100,
        textController: controller,));
      },
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, InputState>(
      buildWhen: (p, c) => p.password != c.password,
      builder: (context, state) {
        return FormInput(
          isConfidential: true,
          hintText: "Password",
          eventFunc: (password) {
            context.read<LoginBloc>().add(PasswordChanged(password));
          },
          height: 100,
          textController: controller,
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

        return Row(children:[Expanded(child:Container(child:FormButton(
          eventFunc: () => context.read<LoginBloc>().add(const FormSubmitted()),
          text: "Sign in",
        )))]);
      },
    );
  }
}
