import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_social_media/pages/register/register_bloc.dart';
import 'package:recipe_social_media/pages/register/register_page.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/utilities/utilities.dart';
import '../../../../test_utilities/mocks/generic_mocks.dart';

void main() {
  late ImageBuilderMock imageBuilderMock;
  
  setUp(() {
    imageBuilderMock = ImageBuilderMock();
    when(() => imageBuilderMock.getAssetImage(any()))
        .thenReturn(const AssetImage("assets/images/light_auth_bg.png"));
  });
  
  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthenticationRepository>(create: (_) => AuthenticationRepositoryMock()),
          RepositoryProvider<NetworkManager>(create: (_) => NetworkManagerMock()),
          RepositoryProvider<ImageBuilder>(create: (_) => imageBuilderMock)
        ],
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
      expect(boxDeco.image!.image, const AssetImage("assets/images/light_auth_bg.png"));
      expect(find.text("Welcome"), findsOneWidget);
      expect(find.text("Sign Up"), findsOneWidget);
      expect(find.text("Already got an account?    "), findsOneWidget);
      expect(find.text("Sign In"), findsOneWidget);
      expect(find.byType(RegisterForm), findsOneWidget);
    });
  });
}