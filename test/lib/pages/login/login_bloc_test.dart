import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_social_media/forms/bloc/base_form.dart';
import 'package:recipe_social_media/forms/models/form_models.dart';
import 'package:recipe_social_media/pages/login/login_bloc.dart';
import '../../../../test_utilities/mocks/generic_mocks.dart';

void main() {
  late AuthenticationRepositoryMock authRepoMock;

  setUp(() {
    authRepoMock = AuthenticationRepositoryMock();
  });

  group("formSubmitted method tests", () {
    blocTest("form submission success",
      build: () {
        when(() => authRepoMock.loginWithHandlerOrEmail(any(), any())).thenAnswer((invocation) => Future.value(""));
        return LoginBloc(authRepo: authRepoMock);
      },
      act: (bloc) {
        bloc.add(const EmailChanged("mail@mail.com"));
        bloc.add(const PasswordChanged("Password123!"));
        bloc.add(const FormSubmitted());
      },
      skip: 2,
        expect: () => [
          const InputState(
            formStatus: FormzSubmissionStatus.inProgress,
            errorMessage: "",
            email: Email.dirty("mail@mail.com"),
            password: Password.dirty("Password123!"),
            confirmedPassword: ConfirmedPassword.dirty(password: "Password123!"),
            emailValid: true,
            passwordValid: true,
            confirmedPasswordValid: false
          ),
          const InputState(
            formStatus: FormzSubmissionStatus.success,
            errorMessage: "",
            email: Email.dirty("mail@mail.com"),
            password: Password.dirty("Password123!"),
            confirmedPassword: ConfirmedPassword.dirty(password: "Password123!"),
            emailValid: true,
            passwordValid: true,
            confirmedPasswordValid: false
          )
        ]
    );

    blocTest("general form submission failure",
      build: () {
        when(() => authRepoMock.loginWithHandlerOrEmail(any(), any())).thenAnswer((invocation) => Future.value("form error"));
        return LoginBloc(authRepo: authRepoMock);
      },
      act: (bloc) {
        bloc.add(const EmailChanged("mail@mail.com"));
        bloc.add(const PasswordChanged("Password123!"));
        bloc.add(const FormSubmitted());
      },
      skip: 2,
      expect: () => [
        const InputState(
          formStatus: FormzSubmissionStatus.inProgress, 
          errorMessage: "",
          email: Email.dirty("mail@mail.com"),
          password: Password.dirty("Password123!"),
          confirmedPassword: ConfirmedPassword.dirty(password: "Password123!"),
          emailValid: true,
          passwordValid: true,
          confirmedPasswordValid: false
        ),
        const InputState(
          formStatus: FormzSubmissionStatus.failure,
          errorMessage: "form error",
          email: Email.dirty("mail@mail.com"),
          password: Password.dirty("Password123!"),
          confirmedPassword: ConfirmedPassword.dirty(password: "Password123!"),
          emailValid: true,
          passwordValid: true,
          confirmedPasswordValid: false
        )
      ]
    );

    blocTest("email/handler field empty, form submission failure",
        build: () {
          when(() => authRepoMock.loginWithHandlerOrEmail(any(), any())).thenAnswer((invocation) => Future.value("form error"));
          return LoginBloc(authRepo: authRepoMock);
        },
        act: (bloc) {
          bloc.add(const PasswordChanged("Password123!"));
          bloc.add(const FormSubmitted());
        },
        skip: 1,
        expect: () => [
          const InputState(
            formStatus: FormzSubmissionStatus.failure,
            errorMessage: "Fields can't be empty",
            password: Password.dirty("Password123!"),
            confirmedPassword: ConfirmedPassword.dirty(password: "Password123!"),
            passwordValid: true,
            confirmedPasswordValid: false
          )
        ]
    );

    blocTest("password field empty, form submission failure",
        build: () {
          when(() => authRepoMock.loginWithHandlerOrEmail(any(), any())).thenAnswer((invocation) => Future.value("form error"));
          return LoginBloc(authRepo: authRepoMock);
        },
        act: (bloc) {
          bloc.add(const EmailChanged("mail@mail.com"));
          bloc.add(const FormSubmitted());
        },
        skip: 1,
        expect: () => [
          const InputState(
            formStatus: FormzSubmissionStatus.failure,
            errorMessage: "Fields can't be empty",
              email: Email.dirty("mail@mail.com"),
              emailValid: true,
          )
        ]
    );
  });
}