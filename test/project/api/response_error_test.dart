import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_social_media/api/response_error.dart';
import '../../mocks/http_response_mock.dart';

void main() {
  late ResponseMock responseMock;

  setUp(() {
    responseMock = ResponseMock();
    when(() => responseMock.body).thenReturn('"body msg"');
  });

  group("ResponseError tests", () {
    group("getErrorMessageFromCode method tests", () {
      test("status code is 500", () {
        // Arrange
        when(() => responseMock.statusCode).thenReturn(500);

        // Act
        final result = ResponseError.getErrorMessageFromCode("default err msg", responseMock);

        // Assert
        expect(result, "default err msg");
      });

      test("status code is 400", () {
        // Arrange
        when(() => responseMock.statusCode).thenReturn(400);

        // Act
        final result = ResponseError.getErrorMessageFromCode("default err msg", responseMock);

        // Assert
        expect(result, "body msg");
      });

      test("status code falls under 'default'", () {
        // Arrange
        when(() => responseMock.statusCode).thenReturn(200);

        // Act
        final result = ResponseError.getErrorMessageFromCode("default err msg", responseMock);

        // Assert
        expect(result, null);
      });

      test("response body is false", () {
        // Arrange
        when(() => responseMock.statusCode).thenReturn(200);
        when(() => responseMock.body).thenReturn("false");

        // Act
        final result = ResponseError.getErrorMessageFromCode("default err msg", responseMock);

        // Assert
        expect(result, "default err msg");
      });
    });
  });
}