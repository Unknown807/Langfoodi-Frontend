import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_social_media/forms/models/form_models.dart';

void main() {
  group("FormValidationError tests", () {
    group("getErrorMessage method tests", () {
      test("emailInvalid error", () {
        // Act
        final result = FormValidationError.getErrorMessage(FormValidationError.emailInvalid);

        // Assert
        expect(result, "Invalid email");
      });

      test("handlerInvalid error", () {
        // Act
        final result = FormValidationError.getErrorMessage(FormValidationError.handlerInvalid);

        // Assert
        expect(result, "Needs 3+ length & only letters/numbers/spaces or underscore");
      });

      test("userNameInvalid error", () {
        // Act
        final result = FormValidationError.getErrorMessage(FormValidationError.userNameInvalid);

        // Assert
        expect(result, "Needs 3+ length & only letters/numbers/spaces or underscore");
      });

      test("passwordInvalid error", () {
        // Act
        final result = FormValidationError.getErrorMessage(FormValidationError.passwordInvalid);

        // Assert
        expect(result, "Needs 8+ length & 1 uppercase, 1 lowercase, 1 digit & 1 special");
      });

      test("confirmedPasswordNoMatch error", () {
        // Act
        final result = FormValidationError.getErrorMessage(FormValidationError.confirmedPasswordNoMatch);

        // Assert
        expect(result, "Passwords must match");
      });

      test("non-existent FormValidationError", () {
        // Act
        final result = FormValidationError.getErrorMessage(null);

        // Assert
        expect(result, isNull);
      });
    });
  });
}