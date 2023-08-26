import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_social_media/pages/home/home_page.dart';
import '../../../../../test_utilities/fakes/page_lander_fake.dart';

void main() {
  Widget createWidgetUnderTest() {
    return const MaterialApp(
        home: Scaffold(
          bottomNavigationBar: NavBarView(widgetPages: [
            PageLanderFake(pageText: "home page"),
            PageLanderFake(pageText: "recipes page"),
            PageLanderFake(pageText: "chats page"),
            PageLanderFake(pageText: "notifications page"),
          ]),
        )
    );
  }

  group("NavBarView tests", () {
    testWidgets("All properties for NavBarView are defined", (widgetTester) async {
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

    testWidgets("on 'Home' page", (widgetTester) async {
      // Arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.byType(TopAppBar), findsOneWidget);
      expect(find.text("home page"), findsOneWidget);
    });

    testWidgets("on 'My Recipes' page", (widgetTester) async {
      // Arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());

      // Act
      await widgetTester.tap(find.text("My Recipes"));
      await widgetTester.pumpAndSettle();

      // Assert
      expect(find.byType(TopAppBar), findsOneWidget);
      expect(find.text("recipes page"), findsOneWidget);
    });

    testWidgets("on 'Chats' page", (widgetTester) async {
      // Arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());

      // Act
      await widgetTester.tap(find.text("Chats"));
      await widgetTester.pumpAndSettle();

      // Assert
      expect(find.byType(TopAppBar), findsOneWidget);
      expect(find.text("chats page"), findsOneWidget);
    });

    testWidgets("on 'Notifications' page", (widgetTester) async {
      // Arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());

      // Act
      await widgetTester.tap(find.text("Notifications"));
      await widgetTester.pumpAndSettle();

      // Assert
      expect(find.byType(TopAppBar), findsOneWidget);
      expect(find.text("notifications page"), findsOneWidget);
    });
  });
}