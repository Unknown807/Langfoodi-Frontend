
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';

void main() {
  group("NewUserContract tests", () {
    group("toMap method tests", () {
      test("map returned", () {
        // Arrange
        var contract = NewUserContract(
            username: "user1",
            email: "mail@example.com",
            password: "pass123"
        );

        // Act
        var result = contract.toMap();

        // Assert
        expect(result, {
          "username": "user1",
          "email": "mail@example.com",
          "password": "pass123"
        });
      });
    });
  });
}