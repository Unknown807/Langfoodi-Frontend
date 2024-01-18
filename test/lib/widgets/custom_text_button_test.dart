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

  Widget createWidgetUnderTest(String text, VoidCallback eventFunc, {double fontSize = 14}) {
    return MaterialApp(
      theme: ThemeData(colorScheme: const ColorScheme.light(secondary: Colors.orange)),
      home: CustomTextButton(
        eventFunc: eventFunc,
        fontSize: fontSize,
        text: text,
      )
    );
  }

  group("custom text button tests", () {
    testWidgets("custom text button with correct theme and function called on tap", (widgetTester) async {
      // Arrange
      await widgetTester.pumpWidget(createWidgetUnderTest("button-text-here", funcMock));

      // Act
      await widgetTester.tap(find.byType(TextButton));

      // Assert
      final TextButton txtBtn = widgetTester.widget(find.byType(TextButton));
      expect(txtBtn.style!.overlayColor!.resolve(<MaterialState>{MaterialState.hovered}), Colors.orange.withAlpha(30));
      expect(txtBtn.style!.overlayColor!.resolve(<MaterialState>{MaterialState.pressed}), Colors.orange.withAlpha(30));
      expect((txtBtn.child as Text).style!.color, Colors.orange);
      expect((txtBtn.child as Text).style!.fontSize, 14);
      expect(find.text("button-text-here"), findsOneWidget);
      verify(funcMock).called(1);
    });
  });
}