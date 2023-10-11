import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_social_media/widgets/shared_widgets.dart';

void main() {
  final List<ScrollItem> items = [
    const ScrollItem(
        "id1",
        "https://daniscookings.com/wp-content/uploads/2021/03/Cinnamon-Roll-Cake-23.jpg",
        "recipe1", subtitle: "subtitle1"),
    const ScrollItem(
        "id2",
        "https://anitalianinmykitchen.com/wp-content/uploads/2018/04/vertical-cake-sq-1-of-1.jpg",
        "recipe2", subtitle: "subtitle2"),
  ];

  Widget createWidgetUnderTest() {
    return MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              height: double.maxFinite,
              child: Column(
                children: [
                  ItemScrollPanel(
                    items: items,
                    scrollDirection: Axis.horizontal,
                    imageAspectRatio: 3/4,
                  )
                ],
              ),
            ),
          ),
        )
    );
  }

  group("item scroll panel tests", () {
    testWidgets("items exist in the panel with titles and subtitles", (widgetTester) async {
      // Arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.text("recipe1"), findsOneWidget);
      expect(find.text("subtitle1"), findsOneWidget);
      expect(find.text("recipe2"), findsOneWidget);
      expect(find.text("subtitle2"), findsOneWidget);
    });
  });
}