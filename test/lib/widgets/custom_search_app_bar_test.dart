import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_social_media/widgets/shared_widgets.dart';
import '../../../test_utilities/fakes/suggestions_builder_fake.dart';
import '../../../test_utilities/mocks/generic_mocks.dart';

void main() {
  late FunctionMock funcMock;

  setUp(() {
    funcMock = FunctionMock();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: CustomSearchBar(
          onChangedFunc: funcMock,
          suggestionsBuilder: SuggestionsBuilderFake.createFakeSuggestionsBuilder(),
          hintText: "hint text here")
    );
  }

  group("custom search bar tests", () {
    testWidgets("search bar visible and can type", (widgetTester) async {
      // Arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());

      // Act
      await widgetTester.enterText(find.byType(TextField), "search term here");

      // Assert
      expect(find.text("hint text here"), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
      verify(() => funcMock("search term here")).called(1);
    });
  });
}