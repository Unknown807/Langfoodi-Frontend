import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import '../../../../../test_utilities/mocks/generic_mocks.dart';

void main() {
  const String userData = "'{'id':null,'userName':'username1','email':'mail@example.com','password':'Password123!'}'";

  group("User model tests", () {
    group("fromJson method tests", () {
      test("create new user object", () {
        // Arrange
        const data = {
          "userName": "username1",
          "email": "mail@example.com",
          "password": "Password123!"
        };

        // Act
        User user = User.fromJson(data);

        // Assert
        expect(user, const User(
          userName: "username1",
          email: "mail@example.com",
          password: "Password123!"
        ));
      });
    });

    group("toMap method tests", () {
      test("create map from user object", () {
        // Arrange
        User user = const User(
          userName: "username1",
          email: "mail@example.com",
          password: "Password123!"
        );

        // Act
        final result = User.toMap(user);

        // Assert
        expect(result, {
          "id": null,
          "userName": "username1",
          "email": "mail@example.com",
          "password": "Password123!"
        });
      });
    });

    group("serialize method tests", () {
      test("map data is encoded into json string", () {
        // Arrange
        User user = const User(
          userName: "username1",
          email: "mail@example.com",
          password: "Password123!"
        );
        JsonWrapperMock jsonWrapperMock = JsonWrapperMock();
        when(() => jsonWrapperMock.encodeData(any()))
          .thenReturn(userData);

        // Act
        final result = User.serialize(user, jsonWrapperMock);

        // Assert
        expect(result, userData);
      });
    });

    group("deserialize method tests", () {
      test("json string is decoded into map object", () {
        // Arrange
        const data = userData;
        JsonWrapperMock jsonWrapperMock = JsonWrapperMock();
        when(() => jsonWrapperMock.decodeData(any()))
          .thenReturn({
          "userName": "username1",
          "email": "mail@example.com",
          "password": "Password123!"
        });

        // Act
        final result = User.deserialize(data, jsonWrapperMock);

        // Assert
        expect(result, const User(
            userName: "username1",
            email: "mail@example.com",
            password: "Password123!"
        ));
      });
    });
  });
}