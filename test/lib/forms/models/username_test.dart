
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_social_media/forms/models/models.dart';

void main() {
  late Username userName;

  setUp(() {
    userName = const Username.pure();
  });

  group("Username model tests", () {
    group("validator method tests", () {
      test("valid usernames", () {
        // Act
        final resultArr = [
          userName.validator("user123"),
          userName.validator("123user"),
          userName.validator("usr"),
          userName.validator("123"),
          userName.validator("USER123"),
          userName.validator("123USER"),
          userName.validator("USR"),
        ];

        // Assert
        expect(resultArr.every((e) => e == null), isTrue);
      });

      test("invalid usernames", () {
        // Act
        final resultArr = [
          userName.validator(null),
          userName.validator(""),
          userName.validator(" "),
          userName.validator("     "),
          userName.validator(" 12"),
          userName.validator("  2"),
          userName.validator("2  "),
          userName.validator("12 "),
          userName.validator("u"),
          userName.validator("us"),
          userName.validator("U"),
          userName.validator("US"),
          userName.validator("1"),
          userName.validator("12"),
          userName.validator("!%^\$"),
          userName.validator("user123!"),
          userName.validator("!user123"),
          userName.validator("user!123"),
          userName.validator("\61"),
          userName.validator("1\6"),
          userName.validator("''''''")
        ];

        // Assert
        expect(resultArr.every((e) => e == FormValidationError.userNameInvalid), isTrue);
      });
    });
  });
}