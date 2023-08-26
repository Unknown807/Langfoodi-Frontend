import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_social_media/pages/home/home_page.dart';

void main() {
  Widget createWidgetUnderTest() {
    return MaterialApp(
        home: Scaffold(
          appBar: TopAppBar(title: const Text("title here"), appBar: AppBar()),
        )
    );
  }

  group("TopAppBar tests", () {
    testWidgets("All properties for TopAppBar are defined", (widgetTester) async {
      // Arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
    });
  });
}