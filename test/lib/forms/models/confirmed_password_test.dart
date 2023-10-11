import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_social_media/forms/models/form_models.dart';

void main() {
  late ConfirmedPassword confirmedPassword;

  setUp(() {
    confirmedPassword = const ConfirmedPassword.dirty(password: "Password123!");
  });

  group("ConfirmedPassword model tests", () {
    group("validator method tests", () {
      test("valid confirmed passwords", () {
        // Act
        final result = confirmedPassword.validator("Password123!");

        // Assert
        expect(result, isNull);
      });

      test("invalid confirmed passwords", () {
        // Act
        final resultArr = [
          confirmedPassword.validator(null),
          confirmedPassword.validator(""),
          confirmedPassword.validator(" "),
          confirmedPassword.validator("    "),
          confirmedPassword.validator("'Password123!'"),
          confirmedPassword.validator("Password123"),
          confirmedPassword.validator("Password123! "),
          confirmedPassword.validator(" Password123!"),
          confirmedPassword.validator("Password 123!"),
          confirmedPassword.validator("password123!"),
        ];

        // Assert
        expect(resultArr.every((e) => e == FormValidationError.confirmedPasswordNoMatch), isTrue);
      });
    });
  });
}