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

  Widget createWidgetUnderTest(String text, [VoidCallback? eventFunc, Color? bgColor, Color? fgColor]) {
    return MaterialApp(
      home: FormButton(
        eventFunc: eventFunc,
        text: text,
        bgColor: bgColor != null ? bgColor! : const Color.fromRGBO(148, 152, 251, 1),
        fgColor: fgColor != null ? fgColor! : Colors.white,
      ),
    );
  }

  group("form button tests", () {
    testWidgets("form button no additional options", (widgetTester) async {
      // Arrange
      await widgetTester.pumpWidget(createWidgetUnderTest("form-button-text", funcMock));

      // Act
      await widgetTester.tap(find.byType(ElevatedButton));

      // Assert
      final ElevatedButton elvBtn = widgetTester.widget(find.byType(ElevatedButton));
      expect(elvBtn.style!.backgroundColor!.resolve(<MaterialState>{}), const Color.fromRGBO(148, 152, 251, 1));
      expect(elvBtn.style!.foregroundColor!.resolve(<MaterialState>{}), Colors.white);
      expect(find.text("form-button-text"), findsOneWidget);
      verify(funcMock).called(1);
    });

    testWidgets("form button with additional options", (widgetTester) async {
      // Arrange
      await widgetTester.pumpWidget(createWidgetUnderTest(
        "new-button-text",
          funcMock,
        Colors.deepOrange,
        Colors.indigo
      ));

      // Act
      await widgetTester.tap(find.byType(ElevatedButton));

      // Assert
      final ElevatedButton elvBtn = widgetTester.widget(find.byType(ElevatedButton));
      expect(elvBtn.style!.backgroundColor!.resolve(<MaterialState>{}), Colors.deepOrange);
      expect(elvBtn.style!.foregroundColor!.resolve(<MaterialState>{}), Colors.indigo);
      expect(find.text("new-button-text"), findsOneWidget);
      verify(funcMock).called(1);
    });
  });
}