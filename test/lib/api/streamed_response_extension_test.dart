import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:recipe_social_media/api/api.dart';

void main() {
  StreamedResponse createSystemUnderTest(int statusCode) =>
      StreamedResponse(StreamController<List<int>>().stream, statusCode);

  group("isOk getter tests", () {
    test("status code is within Ok range", () {
      // Arrange
      var sut = createSystemUnderTest(200);

      // Act
      var result = sut.isOk;

      // Assert
      expect(result, isTrue);
    });

    test("status code is not within Ok range", () {
      // Arrange
      var sut = createSystemUnderTest(300);

      // Act
      var result = sut.isOk;

      // Assert
      expect(result, isFalse);
    });
  });
}