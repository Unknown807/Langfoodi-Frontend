import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_social_media/forms/widgets/form_widgets.dart';
import '../../../mocks/generic_mocks.dart';

void main() {
  late FunctionMock funcMock;

  setUp(() {
    funcMock = FunctionMock();
  });

  Widget createWidgetUnderTest(String text, [VoidCallback? eventFunc, double? fontSize, Color? overlayColor, Color? textColor]) {
    return MaterialApp(
      home: FormTextButton(
        eventFunc: eventFunc,
        text: text,
        fontSize: fontSize ?? 14,
        overlayColor: overlayColor ?? const Color.fromRGBO(143, 148, 251, .5),
        textColor: textColor ?? const Color.fromRGBO(105, 110, 253, 1)
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
        16,
        Colors.deepOrange,
        Colors.indigo
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