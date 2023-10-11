import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_social_media/app/app.dart';
import '../../../test_utilities/mocks/generic_mocks.dart';

void main() {
  late ClientMock clientMock;
  late ReferenceWrapperMock<Client> refWrapperMock;
  late AppLifeCycleObserver sut;

  setUp(() {
    clientMock = ClientMock();
    refWrapperMock = ReferenceWrapperMock();
    when(() => refWrapperMock.getInstance()).thenReturn(clientMock);

    sut = AppLifeCycleObserver(refWrapperMock);
    registerFallbackValue(ClientMock());
  });

  group("didChangeAppLifeCycleState method tests", () {
    test("app life cycle is paused", () {
      // Arrange
      AppLifecycleState state = AppLifecycleState.paused;

      // Act
      sut.didChangeAppLifecycleState(state);

      // Assert
      verify(() => refWrapperMock.getInstance()).called(1);
      verify(() => clientMock.close()).called(1);
    });

    test("app life cycle is resumed", () {
      // Arrange
      AppLifecycleState state = AppLifecycleState.resumed;

      // Act
      sut.didChangeAppLifecycleState(state);

      // Assert
      verify(() => refWrapperMock.setInstance(any())).called(1);
    });
  });
}