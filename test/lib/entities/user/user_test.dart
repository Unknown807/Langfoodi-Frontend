import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_social_media/entities/user/user_entities.dart';
import '../../../../test_utilities/mocks/generic_mocks.dart';

void main() {
  const String userData = '{"id":"id1","handler":"testHandler","userName":"test1","email":"test1@mail.com","password":"Password123!","accountCreationDate":"2023-11-08","profileImageId":"imageId","pinnedConversationIds": ["convoId1"]}';
  const userMap = {
    "id": "id1",
    "handler": "testHandler",
    "userName": "test1",
    "email": "test1@mail.com",
    "password": "Password123!",
    "accountCreationDate": "2023-11-08",
    "profileImageId": "imageId",
    "pinnedConversationIds": ["convoId1"]
  };
  late JsonWrapperMock jsonWrapperMock;

  setUp(() {
    jsonWrapperMock = JsonWrapperMock();
    when(() => jsonWrapperMock.encodeData(any())).thenReturn(userData);
    when(() => jsonWrapperMock.decodeData(any())).thenReturn(userMap);
  });

  group("User model tests", () {
    group("fromJsonStr method tests", () {
      test("create new user object", () {
        // Act
        final user = User.fromJsonStr(userData, jsonWrapperMock);

        // Assert
        expect(user, User(
          "id1", "testHandler",
          "test1", "test1@mail.com",
          "Password123!", DateTime.parse("2023-11-08"),
          "imageId", const ["convoId1"]
        ));
      });
    });

    group("fromJson method tests", () {
      test("create new user object", () {
        // Act
        final user = User.fromJson(userMap);

        // Assert
        expect(user, User(
          "id1", "testHandler",
          "test1", "test1@mail.com",
          "Password123!", DateTime.parse("2023-11-08"),
          "imageId", const ["convoId1"]
        ));
      });
    });

    group("toJson method tests", () {
      test("create map from user object", () {
        // Arrange
        final user = User(
          "id1", "testHandler",
          "test1", "test1@mail.com",
          "Password123!", DateTime.parse("2023-11-08"),
          "imageId", const ["convoId1"]
        );

        // Act
        final result = user.toJson();

        // Assert
        expect(result, {
          "id": "id1",
          "handler": "testHandler",
          "userName": "test1",
          "email": "test1@mail.com",
          "password": "Password123!",
          "accountCreationDate": "2023-11-08 00:00:00.000",
          "profileImageId": "imageId",
          "pinnedConversationIds": ["convoId1"]
        });
      });
    });

    group("serialize method tests", () {
      test("map data is encoded into json string", () {
        // Arrange
        final user = User(
          "id1", "testHandler",
          "test1", "test1@mail.com",
          "Password123!", DateTime.parse("2023-11-08"),
          "imageId", const ["convoId1"]
        );

        // Act
        final result = user.serialize(jsonWrapperMock);

        // Assert
        expect(result, userData);
      });
    });
  });
}