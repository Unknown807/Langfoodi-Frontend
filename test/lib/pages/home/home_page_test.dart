import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_social_media/pages/home/home_page.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/navigation/navigation_repo.dart';
import 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';
import '../../../../test_utilities/mocks/generic_mocks.dart';

void main() {
  Widget createWidgetUnderTest() {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<RecipeRepository>(create: (_) => RecipeRepositoryMock()),
        RepositoryProvider<AuthenticationRepository>(create: (_) => AuthenticationRepositoryMock()),
        RepositoryProvider<NavigationRepository>(create: (_) => NavigationRepositoryMock())
      ],
      child: const MaterialApp(
        home: HomePage(),
      ));
  }

  group("home page tests", () {
    testWidgets("All home page tabs exist", (widgetTester) async {
      // Arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.byIcon(Icons.chat), findsOneWidget);
      expect(find.text("Conversations"), findsNWidgets(2));
      expect(find.byIcon(Icons.fastfood), findsOneWidget);
      expect(find.text("My Recipes"), findsOneWidget);
      expect(find.byIcon(Icons.person), findsAtLeastNWidgets(1));
      expect(find.text("Profile"), findsOneWidget);
      expect(find.byIcon(Icons.notifications), findsOneWidget);
      expect(find.text("Notifications"), findsOneWidget);
    });
  });
}
