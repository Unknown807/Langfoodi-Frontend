import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_social_media/repositories/navigation/navigation_repo.dart';
import 'package:recipe_social_media/widgets/custom_alert_dialog.dart';
import '../../../test_utilities/mocks/generic_mocks.dart';

void main() {
  late NavigationRepositoryMock navigationRepositoryMock;
  late FunctionMock leftBtnFuncMock;
  late FunctionMock rightBtnFuncMock;

  setUp(() {
    navigationRepositoryMock = NavigationRepositoryMock();
    leftBtnFuncMock = FunctionMock();
    rightBtnFuncMock = FunctionMock();

    registerFallbackValue(BuildContextMock());
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: RepositoryProvider<NavigationRepository>(
        create: (context) => navigationRepositoryMock,
        child: Scaffold(
          body: CustomAlertDialog(
            title: const Text("Dialog Title Here"),
            content: const Text("Dialog Content Here"),
            leftButtonCallback: leftBtnFuncMock,
            rightButtonCallback: rightBtnFuncMock,
          ),
        )
      )
    );
  }

  testWidgets("Left dialog button pressed", (widgetTester) async {
    // Arrange
    await widgetTester.pumpWidget(createWidgetUnderTest());

    // Act & Assert
    expect(find.text("Dialog Title Here"), findsOneWidget);
    expect(find.text("Dialog Content Here"), findsOneWidget);
    expect(find.text("Cancel"), findsOneWidget);
    expect(find.text("Ok"), findsOneWidget);
    await widgetTester.tap(find.text("Cancel"));

    verify(leftBtnFuncMock).called(1);
    verify(() => navigationRepositoryMock.dismissDialog(any())).called(1);
    verifyNever(rightBtnFuncMock);
  });

  testWidgets("Right dialog button pressed", (widgetTester) async {
    // Arrange
    await widgetTester.pumpWidget(createWidgetUnderTest());

    // Act & Assert
    expect(find.text("Dialog Title Here"), findsOneWidget);
    expect(find.text("Dialog Content Here"), findsOneWidget);
    expect(find.text("Cancel"), findsOneWidget);
    expect(find.text("Ok"), findsOneWidget);
    await widgetTester.tap(find.text("Ok"));

    verify(rightBtnFuncMock).called(1);
    verify(() => navigationRepositoryMock.dismissDialog(any())).called(1);
    verifyNever(leftBtnFuncMock);
  });
}