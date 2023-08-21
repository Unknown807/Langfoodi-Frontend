import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_social_media/utilities/utilities.dart';
import '../../../test_utilities/fakes/generic_fakes.dart';
import '../../../test_utilities/mocks/generic_mocks.dart';

void main() {
  late JsonConvertibleFakeSubClass jsonConvertibleFakeSubClass;
  late JsonWrapperMock jsonWrapperMock;

  setUp(() {
    jsonConvertibleFakeSubClass = JsonConvertibleFakeSubClass();
    jsonWrapperMock = JsonWrapperMock();
    when(() => jsonWrapperMock.encodeData(any())).thenReturn('"{"test-key":"test-value"}"');
  });

  group("fromJsonStr method tests", () {
    test("method called, nothing happens", () {
      // Act
      final result = JsonConvertible.fromJsonStr("", jsonWrapperMock);

      // Assert
      expect(result, isNull);
    });
  });

  group("fromJson method tests", () {
    test("method called, nothing happens", () {
      // Act
      final result = JsonConvertible.fromJson({}, jsonWrapperMock);

      // Assert
      expect(result, isNull);
    });
  });

  group("toJson method tests", () {
    test("method called, nothing happens", () {
      // Act
      final result = jsonConvertibleFakeSubClass.toJson();

      // Assert
      expect(result, isNull);
    });
  });

  group("serialize method tests", () {
    test("method called, object is serialized", () {
      // Acts
      final result = jsonConvertibleFakeSubClass.serialize(jsonWrapperMock);

      // Assert
      expect(result, '"{"test-key":"test-value"}"');
      verify(() => jsonWrapperMock.encodeData(any())).called(1);
    });
  });
}