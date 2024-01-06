import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_social_media/utilities/utilities.dart';
import 'package:recipe_social_media/widgets/shared_widgets.dart';
import '../../../../test_utilities/mocks/generic_mocks.dart';

void main() {
  final List<ScrollItem> items = [
    ScrollItem(
      "id1",
      "recipe1",
      urlImage: "https://daniscookings.com/wp-content/uploads/2021/03/Cinnamon-Roll-Cake-23.jpg"),
    ScrollItem(
      "id2",
      "recipe2",
      urlImage: "https://anitalianinmykitchen.com/wp-content/uploads/2018/04/vertical-cake-sq-1-of-1.jpg"),
  ];

  late ImageBuilderMock imageBuilderMock;

  setUp(() {
    imageBuilderMock = ImageBuilderMock();

    when(() => imageBuilderMock.decideOnAndDisplayImage(
      isAsset: true,
      imageUrl: any(named: "imageUrl"),
      transformationType: ImageTransformationType.standard,
      errorBuilder: any(named: "errorBuilder")
    )).thenReturn(const Icon(Icons.image));
  });

  Widget createWidgetUnderTest(bool hasButton) {
    return MaterialApp(
        home: RepositoryProvider<ImageBuilder>(
        create: (_) => imageBuilderMock,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              height: double.maxFinite,
              child: Column(
                children: [
                  ItemScrollPanel(
                    hasButton: hasButton,
                    buttonIcon: const Icon(Icons.close_rounded),
                    items: items,
                    scrollDirection: Axis.horizontal,
                    imageAspectRatio: 3/4,
                  )
                ],
              ),
            ),
          ),
        )
    ));
  }

  testWidgets("items exist in the panel with titles and subtitles, no button", (widgetTester) async {
    // Arrange
    await widgetTester.pumpWidget(createWidgetUnderTest(false));

    // Assert
    expect(find.text("recipe1"), findsOneWidget);
    expect(find.text("recipe2"), findsOneWidget);
    expect(find.byIcon(Icons.close_rounded), findsNothing);
    expect(find.byIcon(Icons.image), findsNWidgets(2));
  });

  testWidgets("items exist in the panel with titles and subtitles, with button", (widgetTester) async {
    // Arrange
    await widgetTester.pumpWidget(createWidgetUnderTest(true));

    // Assert
    expect(find.text("recipe1"), findsOneWidget);
    expect(find.text("recipe2"), findsOneWidget);
    expect(find.byIcon(Icons.close_rounded), findsNWidgets(2));
    expect(find.byIcon(Icons.image), findsNWidgets(2));
  });
}