import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_social_media/forms/models/form_models.dart';

void main() {
  late Handler handler;

  setUp(() {
    handler = const Handler.pure();
  });

  group("Handler model tests", () {
    group("validator method tests", () {
      test("valid handlers", () {
        // Act
        final resultArr = [
          handler.validator("user123"),
          handler.validator("123user"),
          handler.validator("usr"),
          handler.validator("123"),
          handler.validator("USER123"),
          handler.validator("123USER"),
          handler.validator("USR"),
          handler.validator("2  "),
          handler.validator("12 "),
          handler.validator("__ "),
          handler.validator("2__  "),
          handler.validator("_     _ "),
        ];

        // Assert
        expect(resultArr.every((e) => e == null), isTrue);
      });

      test("invalid handlers", () {
        // Act
        final resultArr = [
          handler.validator(null),
          handler.validator(""),
          handler.validator(" "),
          handler.validator("     "),
          handler.validator(" 12"),
          handler.validator(" __"),
          handler.validator("_ "),
          handler.validator(" _ "),
          handler.validator("  2"),
          handler.validator("u"),
          handler.validator("us"),
          handler.validator("U"),
          handler.validator("US"),
          handler.validator("1"),
          handler.validator("12"),
          handler.validator("!%^\$"),
          handler.validator("user123!"),
          handler.validator("!user123"),
          handler.validator("user!123"),
          handler.validator("\61"),
          handler.validator("1\6"),
          handler.validator("''''''")
        ];

        // Assert
        expect(resultArr.every((e) => e == FormValidationError.handlerInvalid), isTrue);
      });
    });
  });
}