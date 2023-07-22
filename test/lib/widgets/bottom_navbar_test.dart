import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_social_media/widgets/custom_widgets.dart';

void main() {
  Widget createWidgetUnderTest() {
    return MaterialApp(
        home: Scaffold(
          bottomNavigationBar: BottomNavBar(appBar: AppBar(), selectedIndex: 0),
        )
    );
  }

  group("BottomNavBar tests", () {
    testWidgets("All properties for BottomNavBar are defined", (widgetTester) async {
      // Arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.byIcon(Icons.newspaper), findsOneWidget);
      expect(find.text("Home"), findsOneWidget);
      expect(find.byIcon(Icons.fastfood), findsOneWidget);
      expect(find.text("My creations"), findsOneWidget);
      expect(find.byIcon(Icons.notifications), findsOneWidget);
      expect(find.text("Notifications"), findsOneWidget);
      expect(find.byIcon(Icons.chat), findsOneWidget);
      expect(find.text("Chats"), findsOneWidget);
    });
  });
}