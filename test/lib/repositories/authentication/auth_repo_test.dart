import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import '../../../../test_utilities/mocks/generic_mocks.dart';

void main() {
  const Map<String, String> userMapData = {
    "userName": "username1",
    "email": "mail@example.com",
    "password": "Password123!"
  };
  const String userData = "'{'userName':'username1','email':'mail@example.com','password':'Password123!'}'";
  late RequestMock requestMock;
  late ResponseMock responseMock;
  late LocalStoreMock localStoreMock;
  late JsonWrapperMock jsonWrapperMock;
  late AuthenticationRepository authRepo;

  setUp(() {
    localStoreMock = LocalStoreMock();
    jsonWrapperMock = JsonWrapperMock();
    responseMock = ResponseMock();
    requestMock = RequestMock();

    when(() => requestMock.postWithoutBody(any(), headers: any(named: "headers"))).thenAnswer((invocation) => Future.value(responseMock));
    when(() => requestMock.post<String, String?>(any(), any(), jsonWrapperMock)).thenAnswer((invocation) => Future.value(responseMock));

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
      expect(result, const User(
        userName: "username1",
        email: "mail@example.com",
        password: "Password123!"
      ));
    });
  });

  group("isAuthenticated method tests", () {
    test("no saved user, unauthenticated", () async {
      // Arrange
      when(() => localStoreMock.getKey(any())).thenAnswer((invocation) => Future.value(""));

      // Act
      final result = await authRepo.isAuthenticated();

      // Assert
      expect(result, false);
    });

    test("saved user, status code not 200", () async {
      // Arrange
      when(() => localStoreMock.getKey(any())).thenAnswer((invocation) => Future.value(userData));
      when(() => jsonWrapperMock.decodeData(any())).thenReturn(userMapData);
      when(() => responseMock.statusCode).thenReturn(400);
      when(() => responseMock.body).thenReturn("true");

      // Act
      final result = await authRepo.isAuthenticated();

      // Assert
      expect(result, false);
    });

    test("saved user, status code is 200, response body is true", () async {
      // Arrange
      when(() => localStoreMock.getKey(any())).thenAnswer((invocation) => Future.value(userData));
      when(() => jsonWrapperMock.decodeData(any())).thenReturn(userMapData);
      when(() => responseMock.statusCode).thenReturn(200);
      when(() => responseMock.body).thenReturn("true");

      // Act
      final result = await authRepo.isAuthenticated();

      // Assert
      expect(result, true);
    });

    test("saved user, status code is 200, response body is false", () async {
      // Arrange
      when(() => localStoreMock.getKey(any())).thenAnswer((invocation) => Future.value(userData));
      when(() => jsonWrapperMock.decodeData(any())).thenReturn(userMapData);
      when(() => responseMock.statusCode).thenReturn(200);
      when(() => responseMock.body).thenReturn("false");

      // Act
      final result = await authRepo.isAuthenticated();

      // Assert
      expect(result, false);
    });
  });

  group("register method tests", () {
    test("status code is 200", () async {
      // Arrange
      when(() => localStoreMock.getKey(any())).thenAnswer((invocation) => Future.value(userData));
      when(() => jsonWrapperMock.encodeData(any())).thenReturn(userData);
      when(() => responseMock.statusCode).thenReturn(200);
      when(() => responseMock.body).thenReturn("true");

      // Act
      final result = await authRepo.register("username1", "mail@example.com", "Password123!");

      // Assert
      expect(result, isNull);
      verify(() => localStoreMock.setKey(any(), any())).called(1);
    });

    test("status code is not 200", () async {
      // Arrange
      when(() => responseMock.statusCode).thenReturn(500);
      when(() => responseMock.body).thenReturn("true");

      // Act
      final result = await authRepo.register("username1", "mail@example.com", "Password123!");

      // Assert
      expect(result, "Issue Signing Up");
      verifyNever(() => localStoreMock.setKey(any(), any()));
    });
  });

  group("loginWithUserNameOrEmail method tests", () {
    test("status code is 200, response body is true", () async {
      // Arrange
      when(() => jsonWrapperMock.encodeData(any())).thenReturn(userData);
      when(() => responseMock.statusCode).thenReturn(200);
      when(() => responseMock.body).thenReturn("true");

      // Act
      final result = await authRepo.loginWithUserNameOrEmail("mail@example.com", "Password123!");

      // Assert
      expect(result, isNull);
      verify(() => localStoreMock.setKey(any(), any())).called(1);
    });

    test("status code is 200, response body is true, using username instead of email", () async {
      // Arrange
      when(() => jsonWrapperMock.encodeData(any())).thenReturn(userData);
      when(() => responseMock.statusCode).thenReturn(200);
      when(() => responseMock.body).thenReturn("true");

      // Act
      final result = await authRepo.loginWithUserNameOrEmail("username1", "Password123!");

      // Assert
      expect(result, isNull);
      verify(() => localStoreMock.setKey(any(), any())).called(1);
    });

    test("status code is not 200", () async {
      // Arrange
      when(() => responseMock.statusCode).thenReturn(500);
      when(() => responseMock.body).thenReturn("true");

      // Act
      final result = await authRepo.loginWithUserNameOrEmail("mail@example.com", "Password123!");

      // Assert
      expect(result, "Issue Signing In");
      verifyNever(() => localStoreMock.setKey(any(), any()));
    });

    test("status code is 200, response body is false", () async {
      // Arrange
      when(() => responseMock.statusCode).thenReturn(200);
      when(() => responseMock.body).thenReturn("false");

      // Act
      final result = await authRepo.loginWithUserNameOrEmail("mail@example.com", "Password123!");

      // Assert
      expect(result, "Issue Signing In");
      verifyNever(() => localStoreMock.setKey(any(), any()));
    });
  });

  group("logOut method tests", () {
    test("loggedInUser removed", () async {
      // Act
      await authRepo.logOut();

      // Assert
      verify(() => localStoreMock.deleteKey("loggedInUser")).called(1);
    });
  });
}