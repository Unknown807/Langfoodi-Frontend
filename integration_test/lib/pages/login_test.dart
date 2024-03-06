import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_social_media/pages/login/login_bloc.dart';
import 'package:recipe_social_media/pages/login/login_page.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/navigation/navigation_repo.dart';
import 'package:recipe_social_media/utilities/utilities.dart';
import 'package:recipe_social_media/widgets/shared_widgets.dart';
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
        child: const LoginPage(),
      )
    );
  }

  group("login integration tests", () {
    testWidgets("valid login submission", (widgetTester) async {
      // Arrange
      when(() => authRepoMock.login(any(), any())).thenAnswer((invocation) => Future.value(""));
      await widgetTester.pumpWidget(createSystemUnderTest());

      final emailInput = find.byType(EmailInput);
      final emailTextField = find.descendant(
          of: emailInput,
          matching: find.byType(TextField)
      );

      final passwordInput = find.byType(PasswordInput);
      final passwordTextField = find.descendant(
          of: passwordInput,
          matching: find.byType(TextField)
      );

      // Act
      await widgetTester.enterText(emailTextField, "email@mail.com");
      await widgetTester.enterText(passwordTextField, "Password123!");
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(LoginButton));
      await widgetTester.pumpAndSettle();

      // Assert
      final Text formErrorLabel = widgetTester.widget(find.descendant(
        of: find.byType(FormErrorLabel),
        matching: find.byType(Text)
      ));

      expect(formErrorLabel.data, "");
      expect(find.text("Issue Signing In"), findsNothing);
      verify(() => navigRepoMock.goTo(any(), "/home", routeType: RouteType.onlyThis)).called(1);
    });

    testWidgets("invalid login submission", (widgetTester) async {
      // Arrange
      when(() => authRepoMock.login(any(), any())).thenAnswer((invocation) => Future.value("Issue Signing In"));
      await widgetTester.pumpWidget(createSystemUnderTest());

      final emailInput = find.byType(EmailInput);
      final emailTextField = find.descendant(
          of: emailInput,
          matching: find.byType(TextField)
      );

      final passwordInput = find.byType(PasswordInput);
      final passwordTextField = find.descendant(
          of: passwordInput,
          matching: find.byType(TextField)
      );

      // Act
      await widgetTester.enterText(emailTextField, "email@mail.com");
      await widgetTester.enterText(passwordTextField, "Password123!");
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(LoginButton));
      await widgetTester.pumpAndSettle();

      // Assert
      expect(find.text("Issue Signing In"), findsOneWidget);
      verifyNever(() => navigRepoMock.goTo(any(), "/home", routeType: RouteType.onlyThis));
    });

    testWidgets("Sign up button goes to register page", (widgetTester) async {
      // Arrange
      await widgetTester.pumpWidget(createSystemUnderTest());

      // Act
      final signUpText = find.text("Sign Up");
      final signUpBtn = find.ancestor(of: signUpText, matching: find.byType(CustomTextButton));
      await widgetTester.tap(signUpBtn);
      await widgetTester.pumpAndSettle();

      // Assert
      verify(() => navigRepoMock.goTo(any(), "/register", routeType: RouteType.normal)).called(1);
    });
  });
}