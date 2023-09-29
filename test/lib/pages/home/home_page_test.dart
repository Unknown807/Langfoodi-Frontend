import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_social_media/pages/home/home_page.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';
import '../../../../test_utilities/mocks/generic_mocks.dart';

void main() {
  Widget createWidgetUnderTest() {
    RecipeRepository(RequestMock(), JsonWrapperMock());
    return RepositoryProvider<AuthenticationRepository>(
        create: (_) => AuthenticationRepositoryMock(),
        child: const MaterialApp(
          home: HomePage(),
        ));
  }

  group("home page tests", () {
    testWidgets("All home page tabs exist", (widgetTester) async {
      // Arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.byIcon(Icons.newspaper), findsOneWidget);
      expect(find.text("Home"), findsOneWidget);
      expect(find.byIcon(Icons.fastfood), findsOneWidget);
      expect(find.text("My Recipes"), findsOneWidget);
      expect(find.byIcon(Icons.notifications), findsOneWidget);
      expect(find.text("Notifications"), findsOneWidget);
      expect(find.byIcon(Icons.chat), findsOneWidget);
      expect(find.text("Chats"), findsOneWidget);
    });
  });
}
