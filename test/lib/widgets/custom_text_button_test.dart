import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_social_media/widgets/shared_widgets.dart';
import '../../../test_utilities/mocks/generic_mocks.dart';

void main() {
  late FunctionMock funcMock;

  setUp(() {
    funcMock = FunctionMock();
  });

  Widget createWidgetUnderTest(String text, VoidCallback eventFunc,
      {double fontSize = 14, Color overlayColor = const Color.fromRGBO(143, 148, 251, .5),
      Color textColor = const Color.fromRGBO(105, 110, 253, 1)}) {
    return MaterialApp(
      home: CustomTextButton(
        eventFunc: eventFunc,
        text: text,
        fontSize: fontSize,
        overlayColor: overlayColor,
        textColor: textColor
      )
    );
  }

  group("form text button tests", () {
    testWidgets("form button no additional options", (widgetTester) async {
      // Arrange
      await widgetTester.pumpWidget(createWidgetUnderTest("button-text-here", funcMock));

      // Act
      await widgetTester.tap(find.byType(TextButton));

      // Assert
      final TextButton txtBtn = widgetTester.widget(find.byType(TextButton));
      expect(txtBtn.style!.overlayColor!.resolve(<MaterialState>{}), const Color.fromRGBO(143, 148, 251, .5));
      expect((txtBtn.child as Text).style!.color, const Color.fromRGBO(105, 110, 253, 1));
      expect((txtBtn.child as Text).style!.fontSize, 14);
      expect(find.text("button-text-here"), findsOneWidget);
      verify(funcMock).called(1);
    });

    testWidgets("form button with additional options", (widgetTester) async {
      // Arrange
      await widgetTester.pumpWidget(createWidgetUnderTest(
        "new-button-text-here",
        funcMock,
        fontSize: 16,
        overlayColor: Colors.deepOrange,
        textColor: Colors.indigo
      ));

      // Act
      await widgetTester.tap(find.byType(TextButton));

      // Assert
      final TextButton txtBtn = widgetTester.widget(find.byType(TextButton));
      expect(txtBtn.style!.overlayColor!.resolve(<MaterialState>{}), Colors.deepOrange);
      expect((txtBtn.child as Text).style!.color, Colors.indigo);
      expect((txtBtn.child as Text).style!.fontSize, 16);
      expect(find.text("new-button-text-here"), findsOneWidget);
      verify(funcMock).called(1);
    });
  });
}