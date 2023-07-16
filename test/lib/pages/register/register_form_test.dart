import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_social_media/forms/bloc/base_form.dart';
import 'package:recipe_social_media/forms/models/models.dart';
import 'package:recipe_social_media/forms/widgets/form_widgets.dart';
import 'package:recipe_social_media/pages/register/register_bloc.dart';
import '../../../mocks/generic_mocks.dart';

void main() {
  late RegisterBlocMock registerBlocMock;
  late InputStateMock inputStateMock;

  setUp(() {
    inputStateMock = InputStateMock();
    registerBlocMock = RegisterBlocMock();

    when(() => registerBlocMock.state).thenReturn(inputStateMock);
  });

  group("FormErrorLabel tests", () {
    testWidgets("error label present", (widgetTester) async {
      // Arrange
      when(() => inputStateMock.errorMessage).thenReturn("error msg here");
      final widget = MaterialApp(
        home: BlocProvider<RegisterBloc>(
          create: (_) => registerBlocMock,
          child: const FormErrorLabel(),
        ),
      );

      // Act
      await widgetTester.pumpWidget(widget);

      // Assert
      expect(find.text("error msg here"), findsOneWidget);
    });
  });

  group("UserNameInput tests", () {
    testWidgets("valid username entered", (widgetTester) async {
      // Arrange
      when(() => inputStateMock.userName).thenReturn(const Username.dirty("username1"));
      final widget = MaterialApp(
        home: BlocProvider<RegisterBloc>(
          create: (_) => registerBlocMock,
          child: const Scaffold(
            body: UserNameInput(),
          ),
        ),
      );

      // Act
      await widgetTester.pumpWidget(widget);
      await widgetTester.enterText(find.byType(TextField), "username1");

      // Assert
      final FormInput formInput = widgetTester.widget(find.byType(FormInput));
      expect(formInput.errorText, null);
      verify(() => registerBlocMock.add(const UserNameChanged("username1"))).called(1);
    });

    testWidgets("invalid username entered", (widgetTester) async {
      // Arrange
      when(() => inputStateMock.userName).thenReturn(const Username.dirty("u1"));
      final widget = MaterialApp(
        home: BlocProvider<RegisterBloc>(
          create: (_) => registerBlocMock,
          child: const Scaffold(
            body: UserNameInput(),
          ),
        ),
      );

      // Act
      await widgetTester.pumpWidget(widget);
      await widgetTester.enterText(find.byType(TextField), "u1");

      // Assert
      final FormInput formInput = widgetTester.widget(find.byType(FormInput));
      expect(formInput.errorText, "Needs 3+ length & only letters/numbers");
      verify(() => registerBlocMock.add(const UserNameChanged("u1"))).called(1);
    });
  });

  group("EmailInput tests", () {
    testWidgets("valid email entered", (widgetTester) async {
      // Arrange
      when(() => inputStateMock.email).thenReturn(const Email.dirty("mail@example.com"));
      final widget = MaterialApp(
        home: BlocProvider<RegisterBloc>(
          create: (_) => registerBlocMock,
          child: const Scaffold(
            body: EmailInput(),
          ),
        ),
      );

      // Act
      await widgetTester.pumpWidget(widget);
      await widgetTester.enterText(find.byType(TextField), "mail@example.com");

      // Assert
      final FormInput formInput = widgetTester.widget(find.byType(FormInput));
      expect(formInput.errorText, null);
      verify(() => registerBlocMock.add(const EmailChanged("mail@example.com"))).called(1);
    });

    testWidgets("invalid email entered", (widgetTester) async {
      // Arrange
      when(() => inputStateMock.email).thenReturn(const Email.dirty("mail@"));
      final widget = MaterialApp(
        home: BlocProvider<RegisterBloc>(
          create: (_) => registerBlocMock,
          child: const Scaffold(
            body: EmailInput(),
          ),
        ),
      );

      // Act
      await widgetTester.pumpWidget(widget);
      await widgetTester.enterText(find.byType(TextField), "mail@");

      // Assert
      final FormInput formInput = widgetTester.widget(find.byType(FormInput));
      expect(formInput.errorText, "Invalid email");
      verify(() => registerBlocMock.add(const EmailChanged("mail@"))).called(1);
    });
  });

  group("PasswordInput tests", () {
    testWidgets("valid password entered", (widgetTester) async {
      // Arrange
      when(() => inputStateMock.password).thenReturn(const Password.dirty("Password123!"));
      final widget = MaterialApp(
        home: BlocProvider<RegisterBloc>(
          create: (_) => registerBlocMock,
          child: const Scaffold(
            body: PasswordInput(),
          ),
        ),
      );

      // Act
      await widgetTester.pumpWidget(widget);
      await widgetTester.enterText(find.byType(TextField), "Password123!");

      // Assert
      final FormInput formInput = widgetTester.widget(find.byType(FormInput));
      expect(formInput.errorText, null);
      verify(() => registerBlocMock.add(const PasswordChanged("Password123!"))).called(1);
    });

    testWidgets("invalid password entered", (widgetTester) async {
      // Arrange
      when(() => inputStateMock.password).thenReturn(const Password.dirty("Password"));
      final widget = MaterialApp(
        home: BlocProvider<RegisterBloc>(
          create: (_) => registerBlocMock,
          child: const Scaffold(
            body: PasswordInput(),
          ),
        ),
      );

      // Act
      await widgetTester.pumpWidget(widget);
      await widgetTester.enterText(find.byType(TextField), "Password");

      // Assert
      final FormInput formInput = widgetTester.widget(find.byType(FormInput));
      expect(formInput.errorText, "Needs 8+ length & 1 uppercase, 1 lowercase, 1 digit & 1 special");
      verify(() => registerBlocMock.add(const PasswordChanged("Password"))).called(1);
    });

    group("ConfirmPasswordInput tests", () {
      testWidgets("both passwords matching", (widgetTester) async {
        // Arrange
        when(() => inputStateMock.confirmedPassword).thenReturn(const ConfirmedPassword.dirty(password: "Password123!", value: "Password123!"));
        final widget = MaterialApp(
          home: BlocProvider<RegisterBloc>(
            create: (_) => registerBlocMock,
            child: const Scaffold(
              body: ConfirmPasswordInput(),
            ),
          ),
        );

        // Act
        await widgetTester.pumpWidget(widget);
        await widgetTester.enterText(find.byType(TextField), "Password123!");

        // Assert
        final FormInput formInput = widgetTester.widget(find.byType(FormInput));
        expect(formInput.errorText, null);
        verify(() => registerBlocMock.add(const ConfirmedPasswordChanged("Password123!"))).called(1);
      });

      testWidgets("passwords not matching", (widgetTester) async {
        // Arrange
        when(() => inputStateMock.confirmedPassword).thenReturn(const ConfirmedPassword.dirty(password: "Password123!", value: "Password"));
        final widget = MaterialApp(
          home: BlocProvider<RegisterBloc>(
            create: (_) => registerBlocMock,
            child: const Scaffold(
              body: ConfirmPasswordInput(),
            ),
          ),
        );

        // Act
        await widgetTester.pumpWidget(widget);
        await widgetTester.enterText(find.byType(TextField), "Password123!");

        // Assert
        final FormInput formInput = widgetTester.widget(find.byType(FormInput));
        expect(formInput.errorText, "Passwords must match");
        verify(() => registerBlocMock.add(const ConfirmedPasswordChanged("Password123!"))).called(1);
      });
    });

    group("RegisterButton tests", () {
      testWidgets("form submission in progress", (widgetTester) async {
        // Arrange
        when(() => inputStateMock.formStatus).thenReturn(FormzSubmissionStatus.inProgress);
        final widget = MaterialApp(
          home: BlocProvider<RegisterBloc>(
            create: (_) => registerBlocMock,
            child: const Scaffold(
              body: RegisterButton()
            ),
          ),
        );

        // Act
        await widgetTester.pumpWidget(widget);

        // Assert
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });

      testWidgets("valid form submission", (widgetTester) async {
        // Arrange
        when(() => inputStateMock.formStatus).thenReturn(FormzSubmissionStatus.initial);
        when(() => inputStateMock.userNameValid).thenReturn(true);
        when(() => inputStateMock.emailValid).thenReturn(true);
        when(() => inputStateMock.passwordValid).thenReturn(true);
        when(() => inputStateMock.confirmedPasswordValid).thenReturn(true);
        final widget = MaterialApp(
          home: BlocProvider<RegisterBloc>(
            create: (_) => registerBlocMock,
            child: const Scaffold(
                body: RegisterButton()
            ),
          ),
        );

        // Act
        await widgetTester.pumpWidget(widget);
        await widgetTester.tap(find.byType(ElevatedButton));

        // Assert
        verify(() => registerBlocMock.add(const FormSubmitted())).called(1);
      });

      testWidgets("invalid form submission", (widgetTester) async {
        // Arrange
        when(() => inputStateMock.formStatus).thenReturn(FormzSubmissionStatus.initial);
        when(() => inputStateMock.userNameValid).thenReturn(false);
        when(() => inputStateMock.emailValid).thenReturn(true);
        when(() => inputStateMock.passwordValid).thenReturn(true);
        when(() => inputStateMock.confirmedPasswordValid).thenReturn(true);
        final widget = MaterialApp(
          home: BlocProvider<RegisterBloc>(
            create: (_) => registerBlocMock,
            child: const Scaffold(
                body: RegisterButton()
            ),
          ),
        );

        // Act
        await widgetTester.pumpWidget(widget);
        await widgetTester.tap(find.byType(ElevatedButton));

        // Assert
        verifyNever(() => registerBlocMock.add(const FormSubmitted()));
      });
    });
  });
}