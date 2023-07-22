import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_social_media/pages/register/register_bloc.dart';
import 'package:recipe_social_media/pages/register/register_page.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import '../../../mocks/generic_mocks.dart';

void main() {
  late AuthenticationRepositoryMock authRepoMock;

  setUp(() {
    authRepoMock = AuthenticationRepositoryMock();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: RepositoryProvider<AuthenticationRepository>(
        create: (context) => authRepoMock,
        child: const RegisterPage(),
      ),
    );
  }

  group("register page tests", () {
    testWidgets("ui on page is defined", (widgetTester) async {
      // Arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());
      await widgetTester.pumpAndSettle();

      // Assert
      final Container imgContainer = widgetTester.widget(find.byKey(const Key("registerPageBgImg")).first);
      final BoxDecoration boxDeco = imgContainer.decoration! as BoxDecoration;
      expect(boxDeco.image!.image, const AssetImage("assets/images/background.png"));
      expect(find.text("Welcome"), findsOneWidget);
      expect(find.byType(RegisterForm), findsOneWidget);
    });
  });
}