import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_social_media/app/app_view.dart';
import 'package:recipe_social_media/pages/home/home_page.dart';
import 'package:recipe_social_media/pages/login/login_page.dart';
import 'package:recipe_social_media/pages/splash/splash_page.dart';
import '../../../test_utilities/mocks/generic_mocks.dart';


void main() {
  late AuthenticationRepositoryMock authRepoMock;
  late NavigationRepositoryMock navigRepoMock;

  setUp(() {
    authRepoMock = AuthenticationRepositoryMock();
    navigRepoMock = NavigationRepositoryMock();
  });

  Widget createWidgetUnderTest() {
    return App(authRepo: authRepoMock, navigationRepo: navigRepoMock);
  }

  group("app and app view tests", () {
    testWidgets("app status is authenticated", (widgetTester) async {
      // Arrange
      when(() => authRepoMock.isAuthenticated()).thenAnswer((invocation) => Future.value(true));
      await widgetTester.pumpWidget(createWidgetUnderTest());
      await widgetTester.pumpAndSettle();

      // Assert
      expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets("app status is unauthenticated", (widgetTester) async {
      // Arrange
      when(() => authRepoMock.isAuthenticated()).thenAnswer((invocation) => Future.value(false));
      await widgetTester.pumpWidget(createWidgetUnderTest());
      await widgetTester.pumpAndSettle();

      // Assert
      expect(find.byType(LoginPage), findsOneWidget);
    });

    testWidgets("app status is loading", (widgetTester) async {
      // Arrange
      when(() => authRepoMock.isAuthenticated()).thenAnswer((invocation) => Future.delayed(const Duration(seconds: 5), () => Future.value(false)));
      await widgetTester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.byType(SplashPage), findsOneWidget);
      await widgetTester.pumpAndSettle();
    });
  });
}