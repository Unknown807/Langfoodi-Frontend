import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_social_media/widgets/custom_widgets.dart';

void main() {
  Widget createWidgetUnderTest() {
    return MaterialApp(
        home: Scaffold(
          appBar: NavBar(title: const Text("title here"), appBar: AppBar()),
        )
    );
  }

  group("nav bar tests", () {
    testWidgets("All properties for NavBar are defined", (widgetTester) async {
      // Arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
    });
  });
}