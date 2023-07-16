import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_social_media/forms/bloc/base_form.dart';
import 'package:recipe_social_media/pages/login/login_bloc.dart';
import '../../../mocks/generic_mocks.dart';

void main() {
  late LoginBlocMock loginBlocMock;
  late InputStateMock inputStateMock;

  setUp(() {
    inputStateMock = InputStateMock();
    loginBlocMock = LoginBlocMock();

    when(() => loginBlocMock.state).thenReturn(inputStateMock);
  });

  group("FormErrorLabel tests", () {
    testWidgets("error label present", (widgetTester) async {
      // Arrange
      when(() => inputStateMock.errorMessage).thenReturn("error msg here");
      final widget = MaterialApp(
        home: BlocProvider<LoginBloc>(
          create: (_) => loginBlocMock,
          child: const FormErrorLabel(),
        ),
      );

      // Act
      await widgetTester.pumpWidget(widget);

      // Assert
      expect(find.text("error msg here"), findsOneWidget);
    });
  });

  group("UserNameEmailInput tests", () {
    testWidgets("username or email entered", (widgetTester) async {
      // Arrange
      final widget = MaterialApp(
        home: BlocProvider<LoginBloc>(
          create: (_) => loginBlocMock,
          child: const Scaffold(
            body: UserNameEmailInput()
          )
        ),
      );

      // Act
      await widgetTester.pumpWidget(widget);
      await widgetTester.enterText(find.byType(TextField), "username here");

      // Assert
      verify(() => loginBlocMock.add(const EmailChanged("username here"))).called(1);
      verify(() => loginBlocMock.add(const UserNameChanged("username here"))).called(1);
    });
  });

  group("PasswordInput tests", () {
    testWidgets("password entered", (widgetTester) async {
      // Arrange
      final widget = MaterialApp(
        home: BlocProvider<LoginBloc>(
            create: (_) => loginBlocMock,
            child: const Scaffold(
                body: PasswordInput()
            )
        ),
      );

      // Act
      await widgetTester.pumpWidget(widget);
      await widgetTester.enterText(find.byType(TextField), "Password123!");

      // Assert
      verify(() => loginBlocMock.add(const PasswordChanged("Password123!"))).called(1);
    });
  });

  group("LoginButton tests", () {
    testWidgets("form submission in progress", (widgetTester) async {
      // Arrange
      when(() => inputStateMock.formStatus).thenReturn(FormzSubmissionStatus.inProgress);
      final widget = MaterialApp(
        home: BlocProvider<LoginBloc>(
            create: (_) => loginBlocMock,
            child: const Scaffold(
                body: LoginButton()
            )
        ),
      );

      // Act
      await widgetTester.pumpWidget(widget);

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets("invalid form submission", (widgetTester) async {
      // Arrange
      when(() => inputStateMock.formStatus).thenReturn(FormzSubmissionStatus.initial);
      when(() => inputStateMock.userNameValid).thenReturn(true);
      when(() => inputStateMock.emailValid).thenReturn(true);
      when(() => inputStateMock.passwordValid).thenReturn(false);
      final widget = MaterialApp(
        home: BlocProvider<LoginBloc>(
            create: (_) => loginBlocMock,
            child: const Scaffold(
                body: LoginButton()
            )
        ),
      );

      // Act
      await widgetTester.pumpWidget(widget);
      await widgetTester.tap(find.byType(ElevatedButton));

      // Assert
      verifyNever(() => loginBlocMock.add(const FormSubmitted()));
    });

    testWidgets("valid form submission", (widgetTester) async {
      // Arrange
      when(() => inputStateMock.formStatus).thenReturn(FormzSubmissionStatus.initial);
      when(() => inputStateMock.userNameValid).thenReturn(true);
      when(() => inputStateMock.emailValid).thenReturn(false);
      when(() => inputStateMock.passwordValid).thenReturn(true);
      final widget = MaterialApp(
        home: BlocProvider<LoginBloc>(
            create: (_) => loginBlocMock,
            child: const Scaffold(
                body: LoginButton()
            )
        ),
      );


      // Act
      await widgetTester.pumpWidget(widget);
      await widgetTester.tap(find.byType(ElevatedButton));

      // Assert
      verify(() => loginBlocMock.add(const FormSubmitted())).called(1);
    });
  });
}