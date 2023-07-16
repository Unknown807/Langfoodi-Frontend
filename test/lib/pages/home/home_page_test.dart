import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_social_media/pages/home/home_page.dart';
import 'package:recipe_social_media/widgets/custom_widgets.dart';

// Tests not included for default counter and its behaviours
// as they will be removed soon
// TODO: Remove these comments when counter on home page is removed
void main() {

  Widget createWidgetUnderTest() {
    return const MaterialApp(
      home: HomePage(),
    );
  }

  group("home page tests", () {
    testWidgets("on 'Home' page", (widgetTester) async {
      // Arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.byType(NavBar), findsOneWidget);
      expect(find.byType(BottomNavBar), findsOneWidget);
      expect(find.text("You have pushed the button this many times:"), findsOneWidget);
    });

    testWidgets("on 'My creations' page", (widgetTester) async {
      // Arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());

      // Act
      await widgetTester.tap(find.text("My creations"));
      await widgetTester.pumpAndSettle();

      // Assert
      expect(find.byType(NavBar), findsOneWidget);
      expect(find.byType(BottomNavBar), findsOneWidget);
      expect(find.text("This is the second page!"), findsOneWidget);
    });

    testWidgets("on 'Notifications' page", (widgetTester) async {
      // Arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());

      // Act
      await widgetTester.tap(find.text("Notifications"));
      await widgetTester.pumpAndSettle();

      // Assert
      expect(find.byType(NavBar), findsOneWidget);
      expect(find.byType(BottomNavBar), findsOneWidget);
      expect(find.text("This is the third page!"), findsOneWidget);
    });

    testWidgets("on 'Chats' page", (widgetTester) async {
      // Arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());

      // Act
      await widgetTester.tap(find.text("Chats"));
      await widgetTester.pumpAndSettle();

      // Assert
      expect(find.byType(NavBar), findsOneWidget);
      expect(find.byType(BottomNavBar), findsOneWidget);
      expect(find.text("This is the fourth page!"), findsOneWidget);
    });

    testWidgets("from 'My creations' page to 'Home' page", (widgetTester) async {
      // Arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());

      // Act & Assert
      expect(find.byType(NavBar), findsOneWidget);
      expect(find.byType(BottomNavBar), findsOneWidget);
      expect(find.text("You have pushed the button this many times:"), findsOneWidget);

      await widgetTester.tap(find.text("My creations"));
      await widgetTester.pumpAndSettle();

      expect(find.byType(NavBar), findsOneWidget);
      expect(find.byType(BottomNavBar), findsOneWidget);
      expect(find.text("This is the second page!"), findsOneWidget);

      await widgetTester.tap(find.text("Home"));
      await widgetTester.pumpAndSettle();

      expect(find.byType(NavBar), findsOneWidget);
      expect(find.byType(BottomNavBar), findsOneWidget);
      expect(find.text("You have pushed the button this many times:"), findsOneWidget);
    });
  });

}