import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_social_media/pages/home/home_page.dart';

void main() {
  Widget createWidgetUnderTest() {
    return const MaterialApp(
      home: HomePage(),
    );
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