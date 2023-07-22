import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_social_media/repositories/navigation/navigation_repo.dart';
import '../../../fakes/generic_fakes.dart';
import '../../../mocks/generic_mocks.dart';

void main() {
  late NavigationRepository navigRepo;
  late NavigatorObserverMock navigObserverMock;

  setUp(() {
    navigObserverMock = NavigatorObserverMock();
    navigRepo = NavigationRepository();
    registerFallbackValue(RouteFake());
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: Container(),
      routes: {
        "/home": (context) => Container(),
      },
      navigatorObservers: [navigObserverMock],
    );
  }

  group("navigation repository tests", () {
    testWidgets("normal route type", (widgetTester) async {
      // Arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());
      final BuildContext context = widgetTester.element(find.byType(Container).first);

      // Act
      navigRepo.goTo(context, "/home", RouteType.normal);

      // Assert
      verify(() => navigObserverMock.didPush(any(), any()));
      verifyNever(() => navigObserverMock.didPop(any(), any()));
      verifyNever(() => navigObserverMock.didRemove(any(), any()));
      verifyNever(() => navigObserverMock.didReplace());
    });

    testWidgets("backLink route type", (widgetTester) async {
      // Arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());
      final BuildContext context = widgetTester.element(find.byType(Container).first);

      // Act
      navigRepo.goTo(context, "/home", RouteType.backLink);

      // Assert
      verify(() => navigObserverMock.didPop(any(), any()));
      verify(() => navigObserverMock.didPush(any(), any()));
      verifyNever(() => navigObserverMock.didRemove(any(), any()));
      verifyNever(() => navigObserverMock.didReplace());
    });

    testWidgets("onlyThis route type", (widgetTester) async {
      // Arrange
      await widgetTester.pumpWidget(createWidgetUnderTest());
      final BuildContext context = widgetTester.element(find.byType(Container).first);

      // Act
      navigRepo.goTo(context, "/home", RouteType.onlyThis);

      // Assert
      verify(() => navigObserverMock.didPush(any(), any()));
      verify(() => navigObserverMock.didRemove(any(), any()));
      verifyNever(() => navigObserverMock.didPop(any(), any()));
      verifyNever(() => navigObserverMock.didReplace());
    });
  });
}