import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';

void main() {
  group("AuthenticationAttemptContract tests", () {
    group("toJson method tests", () {
      test("map returned", () {
        // Arrange
        final contract = AuthenticationAttemptContract(
            usernameOrEmail: "mail@example.com",
            password: "pass123"
        );

        // Act
        final result = contract.toJson();

        // Assert
        expect(result, {
          "usernameOrEmail": "mail@example.com",
          "password": "pass123"
        });
      });
    });
  });
}