import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_social_media/pages/recipe_view/recipe_view_page.dart';

void main() {

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: RecipeViewPage(),
    );
  }

  group("recipe view page tests", () {
    group("onLanding method tests", () {
      //TODO: write tests when method is fully implemented
    });

    group("searchBarSuggestionsBuilder method tests", () {
      //TODO: write tests when method is fully implemented
    });
    
    testWidgets("All properties defined for recipe view page", (widgetTester) async {
      // Arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.text("Search Your Recipes"), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.text("Your Recipes"), findsOneWidget);
      expect(find.text("+ Filter"), findsOneWidget);
      expect(find.text("recipe1"), findsOneWidget);
      expect(find.text("subtitle1"), findsOneWidget);
      expect(find.text("recipe2"), findsOneWidget);
      expect(find.text("subtitle2"), findsOneWidget);
      expect(find.text("recipe3"), findsNothing);
      expect(find.text("recipe4"), findsOneWidget);
    });
  });
}