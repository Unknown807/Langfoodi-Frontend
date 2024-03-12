import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_social_media/pages/register/register_bloc.dart';
import 'package:recipe_social_media/pages/register/register_page.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/navigation/navigation_repo.dart';
import 'package:recipe_social_media/utilities/utilities.dart';
import '../../../test_utilities/mocks/generic_mocks.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late AuthenticationRepositoryMock authRepoMock;
  late NavigationRepositoryMock navigRepoMock;
  late ImageBuilderMock imageBuilderMock;
  late NetworkManagerMock networkManagerMock;

  setUp(() {
    authRepoMock = AuthenticationRepositoryMock();
    navigRepoMock = NavigationRepositoryMock();
    imageBuilderMock = ImageBuilderMock();
    networkManagerMock = NetworkManagerMock();

    when(() => imageBuilderMock.getAssetImage(any()))
        .thenReturn(const AssetImage("assets/images/light_auth_bg.png"));

    when(() => networkManagerMock.isNetworkConnected())
        .thenAnswer((invocation) => Future.value(true));

    registerFallbackValue(BuildContextMock());
  });

  Widget createSystemUnderTest() {
    return MaterialApp(
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthenticationRepository>(create: (_) => authRepoMock),
          RepositoryProvider<NavigationRepository>(create: (_) => navigRepoMock),
          RepositoryProvider<ImageBuilder>(create: (_) => imageBuilderMock),
          RepositoryProvider<NetworkManager>(create: (_) => networkManagerMock),
        ],
        child: const RegisterPage(),
      )
    );
  }
  
  group("register integration tests", () {
    testWidgets("valid registration", (widgetTester) async {
      // Arrange
      when(() => authRepoMock.register(any(), any(), any(), any())).thenAnswer((invocation) => Future.value(""));
      await widgetTester.pumpWidget(createSystemUnderTest());

      final handlerTextField = find.descendant(
          of: find.byType(HandlerInput),
          matching: find.byType(TextField)
      );
      final userNameTextField = find.descendant(
        of: find.byType(UserNameInput),
        matching: find.byType(TextField)
      );
      final emailTextField = find.descendant(
          of: find.byType(EmailInput),
          matching: find.byType(TextField)
      );
      final passwordTextField = find.descendant(
          of: find.byType(PasswordInput),
          matching: find.byType(TextField)
      );
      final confirmedPasswordTextField = find.descendant(
          of: find.byType(ConfirmPasswordInput),
          matching: find.byType(TextField)
      );
      
      // Act
      await widgetTester.enterText(handlerTextField, "handler1");
      await widgetTester.enterText(userNameTextField, "username1");
      await widgetTester.enterText(emailTextField, "email@mail.com");
      await widgetTester.enterText(passwordTextField, "Password123!");
      await widgetTester.enterText(confirmedPasswordTextField, "Password123!");
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(RegisterButton));
      await widgetTester.pumpAndSettle();

      // Assert
      final Text formErrorLabel = widgetTester.widget(find.descendant(
        of: find.byType(FormErrorLabel),
        matching: find.byType(Text)
      ));

      expect(formErrorLabel.data, "");
      expect(find.text("Issue Signing Up"), findsNothing);
      expect(find.text("Needs 3+ length & only letters/numbers/spaces or underscore"), findsNothing);
      expect(find.text("Invalid email"), findsNothing);
      expect(find.text("Needs 8+ length & 1 uppercase, 1 lowercase, 1 digit & 1 special"), findsNothing);
      expect(find.text("Passwords must match"), findsNothing);
      verify(() => navigRepoMock.goTo(any(), "/home", routeType: RouteType.onlyThis)).called(1);
    });

    testWidgets("invalid registration form (user error)", (widgetTester) async {
      // Arrange
      when(() => authRepoMock.register(any(), any(), any(), any())).thenAnswer((invocation) => Future.value("Issue Signing Up"));
      await widgetTester.pumpWidget(createSystemUnderTest());

      final handlerTextField = find.descendant(
          of: find.byType(HandlerInput),
          matching: find.byType(TextField)
      );
      final userNameTextField = find.descendant(
          of: find.byType(UserNameInput),
          matching: find.byType(TextField)
      );
      final emailTextField = find.descendant(
          of: find.byType(EmailInput),
          matching: find.byType(TextField)
      );
      final passwordTextField = find.descendant(
          of: find.byType(PasswordInput),
          matching: find.byType(TextField)
      );
      final confirmedPasswordTextField = find.descendant(
          of: find.byType(ConfirmPasswordInput),
          matching: find.byType(TextField)
      );

      // Act
      await widgetTester.enterText(handlerTextField, "h1");
      await widgetTester.enterText(userNameTextField, "u1");
      await widgetTester.enterText(emailTextField, "email@.com");
      await widgetTester.enterText(passwordTextField, "Password123");
      await widgetTester.enterText(confirmedPasswordTextField, "Password123!");
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(RegisterButton));
      await widgetTester.pumpAndSettle();

      // Assert
      final Text formErrorLabel = widgetTester.widget(find.descendant(
          of: find.byType(FormErrorLabel),
          matching: find.byType(Text)
      ));

      expect(formErrorLabel.data, "");
      expect(find.text("Issue Signing Up"), findsNothing);
      expect(find.text("Needs 3+ length & only letters/numbers/spaces or underscore"), findsNWidgets(2));
      expect(find.text("Invalid email"), findsOneWidget);
      expect(find.text("Needs 8+ length & 1 uppercase, 1 lowercase, 1 digit & 1 special"), findsOneWidget);
      expect(find.text("Passwords must match"), findsOneWidget);
      verifyNever(() => navigRepoMock.goTo(any(), "/home", routeType: RouteType.onlyThis));
    });

    testWidgets("invalid registration", (widgetTester) async {
      // Arrange
      when(() => authRepoMock.register(any(), any(), any(), any())).thenAnswer((invocation) => Future.value("Issue Signing Up"));
      await widgetTester.pumpWidget(createSystemUnderTest());

      final handlerTextField = find.descendant(
          of: find.byType(HandlerInput),
          matching: find.byType(TextField)
      );
      final userNameTextField = find.descendant(
          of: find.byType(UserNameInput),
          matching: find.byType(TextField)
      );
      final emailTextField = find.descendant(
          of: find.byType(EmailInput),
          matching: find.byType(TextField)
      );
      final passwordTextField = find.descendant(
          of: find.byType(PasswordInput),
          matching: find.byType(TextField)
      );
      final confirmedPasswordTextField = find.descendant(
          of: find.byType(ConfirmPasswordInput),
          matching: find.byType(TextField)
      );

      // Act
      await widgetTester.enterText(handlerTextField, "handler1");
      await widgetTester.enterText(userNameTextField, "username1");
      await widgetTester.enterText(emailTextField, "email@mail.com");
      await widgetTester.enterText(passwordTextField, "Password123!");
      await widgetTester.enterText(confirmedPasswordTextField, "Password123!");
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(RegisterButton));
      await widgetTester.pumpAndSettle();

      // Assert
      expect(find.text("Issue Signing Up"), findsOneWidget);
      expect(find.text("Needs 3+ length & only letters/numbers/spaces or underscore"), findsNothing);
      expect(find.text("Invalid email"), findsNothing);
      expect(find.text("Needs 8+ length & 1 uppercase, 1 lowercase, 1 digit & 1 special"), findsNothing);
      expect(find.text("Passwords must match"), findsNothing);
      verifyNever(() => navigRepoMock.goTo(any(), "/home", routeType: RouteType.onlyThis));
    });
  });
}