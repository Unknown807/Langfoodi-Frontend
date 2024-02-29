import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_social_media/forms/bloc/base_form.dart';
import 'package:recipe_social_media/forms/models/form_models.dart';

void main() {
  group("_onHandlerChanged method tests", () {
    blocTest("valid handler",
        build: () => FormBloc(),
        act: (bloc) => bloc.add(const HandlerChanged("handler123")),
        expect: () => [InputState(emailTextController: TextEditingController(), passwordTextController: TextEditingController(), handler: Handler.dirty("handler123"), handlerValid: true)]
    );

    blocTest("invalid handler",
        build: () => FormBloc(),
        act: (bloc) => bloc.add(const HandlerChanged("h1")),
        expect: () => [InputState(emailTextController: TextEditingController(), passwordTextController: TextEditingController(), handler: Handler.dirty("h1"), handlerValid: false)]
    );
  });

  group("_onUserNameChanged method tests", () {
    blocTest("valid user name",
      build: () => FormBloc(),
      act: (bloc) => bloc.add(const UserNameChanged("username123")),
      expect: () => [InputState(emailTextController: TextEditingController(), passwordTextController: TextEditingController(), userName: Username.dirty("username123"), userNameValid: true)]
    );

    blocTest("invalid user name",
      build: () => FormBloc(),
      act: (bloc) => bloc.add(const UserNameChanged("u1")),
      expect: () => [InputState(emailTextController: TextEditingController(), passwordTextController: TextEditingController(), userName: Username.dirty("u1"), userNameValid: false)]
    );
  });

  group("_onEmailChanged method tests", () {
    blocTest("valid email",
      build: () => FormBloc(),
      act: (bloc) => bloc.add(const EmailChanged("example@mail.com")),
      expect: () => [InputState(emailTextController: TextEditingController(), passwordTextController: TextEditingController(), email: Email.dirty("example@mail.com"), emailValid: true)]
    );

    blocTest("invalid email",
      build: () => FormBloc(),
      act: (bloc) => bloc.add(const EmailChanged("example@mail.")),
      expect: () => [InputState(emailTextController: TextEditingController(), passwordTextController: TextEditingController(), email: Email.dirty("example@mail."), emailValid: false)]
    );
  });

  group("_passwordChanged method test", () {
    blocTest("valid password, invalid confirmed password",
      build: () => FormBloc(),
      act: (bloc) => bloc.add(const PasswordChanged("Password123!")),
      expect: () => [InputState(
        emailTextController: TextEditingController(),
        passwordTextController: TextEditingController(),
        password: Password.dirty("Password123!"),
        confirmedPassword: ConfirmedPassword.dirty(password: "Password123!", value: ""),
        passwordValid: true,
        confirmedPasswordValid: false
      )]
    );

    blocTest("valid password, valid confirmed password",
      build: () => FormBloc(),
      act: (bloc) => bloc
        ..add(const ConfirmedPasswordChanged("Password123!"))
        ..add(const PasswordChanged("Password123!")),
      skip: 1,
      expect: () => [InputState(
        emailTextController: TextEditingController(),
        passwordTextController: TextEditingController(),
        password: Password.dirty("Password123!"),
        confirmedPassword: ConfirmedPassword.dirty(password: "Password123!", value: "Password123!"),
        passwordValid: true,
        confirmedPasswordValid: true
      )]
    );

    blocTest("invalid password, valid confirmed password",
      build: () => FormBloc(),
      act: (bloc) => bloc
        ..add(const ConfirmedPasswordChanged("pass"))
        ..add(const PasswordChanged("pass")),
      skip: 1,
      expect: () => [InputState(
        emailTextController: TextEditingController(),
        passwordTextController: TextEditingController(),
        password: Password.dirty("pass"),
        confirmedPassword: ConfirmedPassword.dirty(password: "pass", value: "pass"),
        passwordValid: false,
        confirmedPasswordValid: true
      )]
    );

    blocTest("invalid password, invalid confirmed password",
      build: () => FormBloc(),
      act: (bloc) => bloc.add(const PasswordChanged("pass")),
      expect: () => [InputState(
        emailTextController: TextEditingController(),
        passwordTextController: TextEditingController(),
        password: Password.dirty("pass"),
        confirmedPassword: ConfirmedPassword.dirty(password: "pass", value: ""),
        passwordValid: false,
        confirmedPasswordValid: false
      )]
    );
  });

  group("_confirmedPasswordChanged method tests", () {
    blocTest("valid confirmed password, valid password",
      build: () => FormBloc(),
      act: (bloc) => bloc
        ..add(const PasswordChanged("Password123!"))
        ..add(const ConfirmedPasswordChanged("Password123!")),
      skip: 1,
      expect: () => [InputState(
        emailTextController: TextEditingController(),
        passwordTextController: TextEditingController(),
        password: Password.dirty("Password123!"),
        confirmedPassword: ConfirmedPassword.dirty(password: "Password123!", value: "Password123!"),
        passwordValid: true,
        confirmedPasswordValid: true
      )]
    );

    blocTest("valid confirmed password, invalid password",
      build: () => FormBloc(),
      act: (bloc) => bloc
        ..add(const PasswordChanged("pass"))
        ..add(const ConfirmedPasswordChanged("pass")),
      skip: 1,
      expect: () => [InputState(
        emailTextController: TextEditingController(),
        passwordTextController: TextEditingController(),
        password: Password.dirty("pass"),
        confirmedPassword: ConfirmedPassword.dirty(password: "pass", value: "pass"),
        passwordValid: false,
        confirmedPasswordValid: true
      )]
    );

    blocTest("invalid confirmed password, valid password",
      build: () => FormBloc(),
      act: (bloc) => bloc
        ..add(const PasswordChanged("Password123!"))
        ..add(const ConfirmedPasswordChanged("pass")),
      skip: 1,
      expect: () => [InputState(
          emailTextController: TextEditingController(),
          passwordTextController: TextEditingController(),
          password: Password.dirty("Password123!"),
          confirmedPassword: ConfirmedPassword.dirty(password: "Password123!", value: "pass"),
          passwordValid: true,
          confirmedPasswordValid: false
      )]
    );

    blocTest("invalid confirmed password, invalid password",
      build: () => FormBloc(),
      act: (bloc) => bloc
        ..add(const PasswordChanged("password"))
        ..add(const ConfirmedPasswordChanged("pass")),
      skip: 1,
      expect: () => [InputState(
          emailTextController: TextEditingController(),
          passwordTextController: TextEditingController(),
          password: Password.dirty("password"),
          confirmedPassword: ConfirmedPassword.dirty(password: "password", value: "pass"),
          passwordValid: false,
          confirmedPasswordValid: false
      )]
    );
  });

  group("formSubmitted method tests", () {
    blocTest("event received",
      build: () => FormBloc(),
      act: (bloc) => bloc.add(const FormSubmitted()),
      errors: () => [],
      expect: () => []
    );
  });
}