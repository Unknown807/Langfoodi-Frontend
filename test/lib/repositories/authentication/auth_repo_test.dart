import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_social_media/entities/user/user_entities.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import '../../../../test_utilities/mocks/generic_mocks.dart';

void main() {
  const Map<String, dynamic> userMapData = {
    "id": "id1",
    "handler": "testHandler",
    "userName": "test1",
    "email": "test1@mail.com",
    "password": "Password123!",
    "accountCreationDate": "2023-11-08 00:00:00.000",
    "profileImageId": "imageId",
    "pinnedConversationIds": ["convoId1"],
    "blockedConnectionIds": ["connId1"]
  };

  const Map<String, dynamic> authResponseData = {
    "user": userMapData,
    "token": "test_token"
  };
  const String userData = '{"id":"id1","handler":"testHandler","userName":"test1","email":"test1@mail.com","password":"Password123!","accountCreationDate":"2023-11-08","profileImageId":"imageId","pinnedConversationIds": ["convoId1"],"blockedConnectionIds": ["connId1"]}';
  late JsonConvertibleMock jsonConvertibleMock;
  late RequestMock requestMock;
  late ResponseMock responseMock;
  late LocalStoreMock localStoreMock;
  late JsonWrapperMock jsonWrapperMock;
  late AuthenticationRepository authRepo;

  setUp(() {
    jsonConvertibleMock = JsonConvertibleMock();
    localStoreMock = LocalStoreMock();
    jsonWrapperMock = JsonWrapperMock();
    responseMock = ResponseMock();
    requestMock = RequestMock();

    registerFallbackValue(jsonConvertibleMock);
    when(() => requestMock.postWithoutBody(any(), headers: any(named: "headers"))).thenAnswer((invocation) => Future.value(responseMock));
    when(() => requestMock.post(any(), any(), jsonWrapperMock, headers: any(named: "headers"))).thenAnswer((invocation) => Future.value(responseMock));

    authRepo = AuthenticationRepository(localStoreMock, requestMock, jsonWrapperMock);
  });

  group("currentUser method tests", () {
    test("user object de-serialised and retrieved", () async {
      // Arrange
      when(() => localStoreMock.getKey(any())).thenAnswer((invocation) => Future.value(userData));
      when(() => jsonWrapperMock.decodeData(any())).thenReturn(userMapData);

      // Act
      final result = await authRepo.currentUser;

      // Assert
      expect(result, User(
        "id1", "testHandler",
        "test1", "test1@mail.com",
        "Password123!", DateTime.parse("2023-11-08"),
        "imageId", const ["convoId1"], const ["connId1"]
      ));
    });
  });

  group("isAuthenticated method tests", () {
    test("no saved user, unauthenticated", () async {
      // Arrange
      when(() => requestMock.authenticate(any())).thenAnswer((invocation) => Future.value((null, null)));

      // Act
      final result = await authRepo.isAuthenticated();

      // Assert
      expect(result, false);
    });

    test("saved user, status code is 200", () async {
      // Arrange
      when(() => requestMock.authenticate(any())).thenAnswer((invocation) => Future.value((
        User("1", "handler", "UserName", "mail@test.com", "Password123!", DateTime(2024, 1, 1, 0, 0, 0, 0, 0), null, const [], const []), null)));

      // Act
      final result = await authRepo.isAuthenticated();

      // Assert
      expect(result, true);
    });
  });

  group("register method tests", () {
    test("status code is 200", () async {
      // Arrange
      when(() => jsonWrapperMock.decodeData(any())).thenReturn(authResponseData);
      when(() => jsonWrapperMock.encodeData(any())).thenReturn(userData);
      when(() => responseMock.statusCode).thenReturn(200);
      when(() => responseMock.body).thenReturn(userData);
      when(() => requestMock.mapAuthenticationResponse(any())).thenAnswer((invocation) => (
        User("1", "handler1", "username1", "mail@example.com", "Password123!", DateTime(2024, 1, 1, 0, 0, 0, 0, 0), null, const [], const []), "token"));

      // Act
      final result = await authRepo.register("handler1", "username1", "mail@example.com", "Password123!");

      // Assert
      expect(result, "");
      verify(() => localStoreMock.setKey(any(), any())).called(2);
    });

    test("status code is 400", () async {
      // Arrange
      when(() => responseMock.statusCode).thenReturn(400);
      when(() => responseMock.body).thenReturn("Username already exists");

      // Act
      final result = await authRepo.register("handler1", "username1", "mail@example.com", "Password123!");

      // Assert
      expect(result, "Username already exists");
      verifyNever(() => localStoreMock.setKey(any(), any()));
    });

    test("status code is 500", () async {
      // Arrange
      when(() => responseMock.statusCode).thenReturn(500);

      // Act
      final result = await authRepo.register("handler1", "username1", "mail@example.com", "Password123!");

      // Assert
      expect(result, "Issue Signing Up");
      verifyNever(() => localStoreMock.setKey(any(), any()));
    });
  });

  group("loginWithHandlerOrEmail method tests", () {
    test("status code is 200", () async {
      // Arrange
      when(() => jsonWrapperMock.decodeData(any())).thenReturn(authResponseData);
      when(() => jsonWrapperMock.encodeData(any())).thenReturn(userData);
      when(() => responseMock.statusCode).thenReturn(200);
      when(() => responseMock.body).thenReturn(userData);
      when(() => requestMock.authenticate(any())).thenAnswer((_) => Future.value((
        User("1", "handler1", "username1", "mail@example.com", "Password123!", DateTime(2024, 1, 1, 0, 0, 0, 0, 0), null, const [], const []), "token")));

      // Act
      final result = await authRepo.login("mail@example.com", "Password123!");

      // Assert
      expect(result, "");
      verify(() => localStoreMock.setKey(any(), any())).called(1);
    });

    test("status code is 400", () async {
      // Arrange
      when(() => requestMock.authenticate(any())).thenAnswer((_) => Future.value((null, "Invalid Credentials")));

      // Act
      final result = await authRepo.login("handler1", "Password123!");

      // Assert
      expect(result, "Invalid Credentials");
      verifyNever(() => localStoreMock.setKey(any(), any()));
    });

    test("status code is 500", () async {
      // Arrange
      when(() => requestMock.authenticate(any())).thenAnswer((_) => Future.value((null, null)));

      // Act
      final result = await authRepo.login("mail@example.com", "Password123!");

      // Assert
      expect(result, "Issue Signing In");
      verifyNever(() => localStoreMock.setKey(any(), any()));
    });
  });

  group("logOut method tests", () {
    test("loggedInUser removed", () async {
      // Arrange
      when(() => requestMock.tokenKey).thenReturn("authToken");

      // Act
      await authRepo.logOut();

      // Assert
      verify(() => localStoreMock.deleteKey("loggedInUser")).called(1);
      verify(() => localStoreMock.deleteKey("authToken")).called(1);
    });
  });
}