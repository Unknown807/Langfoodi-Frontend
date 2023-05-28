import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:recipe_social_media/forms/input_event.dart';
import 'package:recipe_social_media/forms/widgets/FormInput.dart';
import 'package:recipe_social_media/register/register_bloc.dart';
import '../forms/input_state.dart';
import '../forms/widgets/FormButton.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, InputState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          print("Form Success");
          Navigator.of(context).pop();
        }
      },
      child: Column(children: <Widget>[
        _FormErrorLabel(),
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
            child: Column(children: <Widget>[
              _UserNameInput(),
              _EmailInput(),
              _PasswordInput(),
              _ConfirmPasswordInput(),
            ])),
        const SizedBox(height: 20),
        _RegisterButton()
      ]),
    );
  }
}

class _FormErrorLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, InputState>(
      buildWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage,
      builder: (context, state) {
        return Text(state.errorMessage ?? "",
            style: const TextStyle(
              color: Color.fromRGBO(244, 113, 116, 1),
            ));
      },
    );
  }
}

class _UserNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, InputState>(
      buildWhen: (previous, current) => previous.userName != current.userName,
      builder: (context, state) {
        return FormInput(
            errTxt: state.userName.displayError != null
                ? "Needs 3+ length & only letters/numbers"
                : null,
            hintTxt: "Username",
            eventFunc: (userName) {
              context.read<RegisterBloc>().add(UserNameChanged(userName));
            });
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, InputState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return FormInput(
            errTxt: state.email.displayError != null ? "Invalid email" : null,
            hintTxt: "Email",
            eventFunc: (email) {
              context.read<RegisterBloc>().add(EmailChanged(email));
            });
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, InputState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return FormInput(
          isConfidential: true,
          errTxt: state.password.displayError != null
              ? "Needs 8+ length & one of each character - upper case, lower case, number & special"
              : null,
          hintTxt: "Password",
          eventFunc: (password) {
            context.read<RegisterBloc>().add(PasswordChanged(password));
          },
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, InputState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return FormInput(
          isConfidential: true,
          useBorderStyle: false,
          errTxt: state.confirmedPassword.displayError != null
              ? "passwords must match"
              : null,
          hintTxt: "Confirm Password",
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

class _RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, InputState>(
      builder: (context, state) {
        if (state.status.isInProgress) {
          return const CircularProgressIndicator();
        }

        bool allFieldsValid = state.userNameValid &&
            state.emailValid &&
            state.passwordValid &&
            state.confirmedPasswordValid;
        return FormButton(
          eventFunc: allFieldsValid
              ? () => context.read<RegisterBloc>().add(const FormSubmitted())
              : null,
          btnText: "Sign Up",
        );
      },
    );
  }
}
