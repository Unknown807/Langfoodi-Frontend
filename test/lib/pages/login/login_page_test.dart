import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_social_media/pages/login/login_bloc.dart';
import 'package:recipe_social_media/pages/login/login_page.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/utilities/utilities.dart';
import '../../../../test_utilities/mocks/generic_mocks.dart';

void main() {
  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthenticationRepository>(create: (_) => AuthenticationRepositoryMock()),
          RepositoryProvider<NetworkManager>(create: (_) => NetworkManagerMock())
        ],
        child: const LoginPage(),
      ),
    );
  }

  group("login page tests", () {
    testWidgets("ui on page is defined", (widgetTester) async {
      // Arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());
      await widgetTester.pumpAndSettle();

      // Assert
      final Container imgContainer = widgetTester.widget(find.byKey(const Key("loginPageBgImg")).first);
      final BoxDecoration boxDeco = imgContainer.decoration! as BoxDecoration;
      expect(boxDeco.image!.image, const AssetImage("assets/images/light_auth_bg.png"));
      expect(find.text("Welcome"), findsOneWidget);
      expect(find.byType(LoginForm), findsOneWidget);
    });
  });
}