import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_social_media/pages/home/home_page.dart';

void main() {
  Widget createWidgetUnderTest() {
    return const MaterialApp(
        home: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(56),
              child: TopAppBar(title: "title here"),
    )));
  }

  group("TopAppBar tests", () {
    testWidgets("All properties for TopAppBar are defined",
        (widgetTester) async {
      // Arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
      expect(find.text("title here"), findsOneWidget);
    });
  });
}
