import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_social_media/widgets/shared_widgets.dart';

void main() {
  Widget createWidgetUnderTest() {
    return const MaterialApp(
      home: Scaffold(
        body: CustomIconTile(icon: Icons.abc_sharp, iconColor: Colors.black, tileColor: Colors.black),
      )
    );
  }

  testWidgets("(Custom Icon Tile) dotted border with icon visible", (widgetTester) async {
    // Arrange
    await widgetTester.pumpWidget(createWidgetUnderTest());

    // Assert
    expect(find.byType(DottedBorder), findsOneWidget);
    expect(find.byIcon(Icons.abc_sharp), findsOneWidget);
  });
}