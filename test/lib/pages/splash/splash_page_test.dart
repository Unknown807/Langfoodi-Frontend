import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_social_media/pages/splash/splash_page.dart';

void main() {
  Widget createWidgetUnderTest() {
    return const MaterialApp(
      home: SplashPage(),
    );
  }

  group("splash page tests", () {
    testWidgets("progress indicator present", (widgetTester) async {
      // Arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}