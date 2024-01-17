import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_social_media/forms/widgets/form_widgets.dart';
import '../../../../test_utilities/mocks/generic_mocks.dart';

void main() {
  late FunctionMock funcMock;

  setUp(() {
    funcMock = FunctionMock();
  });

  Widget createWidgetUnderTest(String? errorText, String hint, VoidCallback eventFunc, FormInputBoxDecorationType? boxDeco, {bool isConfidential = false}) {
    return MaterialApp(
      home: Scaffold(
        body: FormInput(
          errorText: errorText,
          hintText: hint,
          eventFunc: eventFunc,
          boxDecorationType: boxDeco,
          isConfidential: isConfidential,
        ),
      )
    );
  }

  group("form input tests", () {
    testWidgets("form input default options", (widgetTester) async {
      // Arrange
      await widgetTester.pumpWidget(createWidgetUnderTest("err-text", "hint-here", funcMock, null));

      // Act
      await widgetTester.enterText(find.byType(TextField), "text-input-here");

      // Assert
      final Container container = widgetTester.widget(find.byType(Container).first);
      expect(container.decoration, isNull);
      final TextField txtField = widgetTester.widget(find.byType(TextField));
      expect(txtField.obscureText, false);
      expect(txtField.decoration!.hintText, "hint-here");
      expect(txtField.decoration!.errorText, "err-text");
      verify(() => funcMock.call("text-input-here")).called(1);
    });

    testWidgets("form input altered options", (widgetTester) async {
      // Arrange
      await widgetTester.pumpWidget(createWidgetUnderTest(
        "err-text",
        "hint-here",
        funcMock,
        FormInputBoxDecorationType.textArea,
        isConfidential: true
      ));

      // Act
      await widgetTester.enterText(find.byType(TextField), "text-input-here");

      // Assert
      final Container container = widgetTester.widget(find.byType(Container).first);
      expect(container.decoration, isNotNull);
      final TextField txtField = widgetTester.widget(find.byType(TextField));
      expect(txtField.obscureText, true);
      expect(txtField.decoration!.hintText, "hint-here");
      expect(txtField.decoration!.errorText, "err-text");
      verify(() => funcMock.call("text-input-here")).called(1);
    });
  });
}