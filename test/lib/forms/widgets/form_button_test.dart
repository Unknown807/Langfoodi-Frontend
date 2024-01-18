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

  Widget createWidgetUnderTest(String text, VoidCallback eventFunc) {
    return MaterialApp(
      theme: ThemeData(colorScheme:
        const ColorScheme.light(primary: Colors.green, onPrimary: Colors.white)),
      home: FormButton(
        eventFunc: eventFunc,
        text: text,
      ),
    );
  }

  group("form button tests", () {
    testWidgets("form button with correct theme and function called on tap", (widgetTester) async {
      // Arrange
      await widgetTester.pumpWidget(createWidgetUnderTest("form-button-text", funcMock));

      // Act
      await widgetTester.tap(find.byType(ElevatedButton));

      // Assert
      final ElevatedButton elvBtn = widgetTester.widget(find.byType(ElevatedButton));
      expect(elvBtn.style!.backgroundColor!.resolve(<MaterialState>{}), Colors.green);
      expect(elvBtn.style!.foregroundColor!.resolve(<MaterialState>{}), Colors.white);
      expect(find.text("form-button-text"), findsOneWidget);
      verify(funcMock).called(1);
    });
  });
}