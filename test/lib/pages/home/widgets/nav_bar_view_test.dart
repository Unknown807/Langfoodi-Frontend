import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_social_media/pages/home/home_page.dart';
import '../../../../../test_utilities/fakes/page_lander_fake.dart';

void main() {
  Widget createWidgetUnderTest() {
    return const MaterialApp(
        home: Scaffold(
          bottomNavigationBar: NavBarView(widgetPages: [
            PageLanderFake(pageText: "conversations page"),
            PageLanderFake(pageText: "recipes page"),
            PageLanderFake(pageText: "profile page"),
            PageLanderFake(pageText: "notifications page"),
          ],
          onLandOnce: [false, true, false, false]),
        )
    );
  }

  group("NavBarView tests", () {
    testWidgets("All tabs for NavBarView are defined", (widgetTester) async {
      // Arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.byIcon(Icons.chat), findsOneWidget);
      expect(find.text("Conversations"), findsOneWidget);
      expect(find.byIcon(Icons.fastfood), findsOneWidget);
      expect(find.text("My Recipes"), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
      expect(find.text("Profile"), findsOneWidget);
      expect(find.byIcon(Icons.notifications), findsOneWidget);
      expect(find.text("Notifications"), findsOneWidget);
    });

    testWidgets("on 'Conversations' page", (widgetTester) async {
      // Arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.text("conversations page"), findsOneWidget);
    });

    testWidgets("on 'My Recipes' page", (widgetTester) async {
      // Arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());

      // Act
      await widgetTester.tap(find.text("My Recipes"));
      await widgetTester.pumpAndSettle();

      // Assert
      expect(find.text("recipes page"), findsOneWidget);
    });

    testWidgets("on 'Profile' page", (widgetTester) async {
      // Arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());

      // Act
      await widgetTester.tap(find.text("Profile"));
      await widgetTester.pumpAndSettle();

      // Assert
      expect(find.text("profile page"), findsOneWidget);
    });

    testWidgets("on 'Notifications' page", (widgetTester) async {
      // Arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());

      // Act
      await widgetTester.tap(find.text("Notifications"));
      await widgetTester.pumpAndSettle();

      // Assert
      expect(find.text("notifications page"), findsOneWidget);
    });
  });
}