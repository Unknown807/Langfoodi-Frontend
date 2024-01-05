import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_social_media/widgets/shared_widgets.dart';

void main() {
  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: Scaffold(
        body: CustomExpansionTile(
          title: const Text("Tile Title Here"),
          children: const [
            Text("Child1 In Tile"),
            Text("Child2 In Tile"),
            Text("Child3 In Tile"),
          ]
        ),
      )
    );
  }

  testWidgets("Collapsed ExpansionTile, child widgets not visible", (widgetTester) async {
    // Arrange
    await widgetTester.pumpWidget(createWidgetUnderTest());

    // Assert
    expect(find.text("Tile Title Here"), findsOneWidget);
    expect(find.text("Child1 In Tile"), findsNothing);
    expect(find.text("Child2 In Tile"), findsNothing);
    expect(find.text("Child3 In Tile"), findsNothing);
  });

  testWidgets("Expanded ExpansionTile, child widgets visible", (widgetTester) async {
    // Arrange
    await widgetTester.pumpWidget(createWidgetUnderTest());

    // Act
    await widgetTester.tap(find.byType(ExpansionTile));
    await widgetTester.pumpAndSettle();

    // Assert
    expect(find.text("Tile Title Here"), findsOneWidget);
    expect(find.text("Child1 In Tile"), findsOneWidget);
    expect(find.text("Child2 In Tile"), findsOneWidget);
    expect(find.text("Child3 In Tile"), findsOneWidget);
  });
}