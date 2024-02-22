import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:recipe_social_media/api/api.dart';
import 'package:recipe_social_media/utilities/utilities.dart';
import '../../../test_utilities/fakes/generic_fakes.dart';
import '../../../test_utilities/mocks/generic_mocks.dart';

void main() {
  late String path;
  late Uri fullPath;
  late MultipartFileProviderMock multipartFileProviderMock;
  late ClientMock clientMock;
  late JsonWrapperMock jsonWrapperMock;
  late LocalStoreMock localStoreMock;
  late JsonConvertibleMock jsonConvertibleMock;
  late Request sut;

  setUp(() {
    path = "/get/user";
    fullPath = Uri.parse("https://localhost:7120/get/user");

    jsonWrapperMock = JsonWrapperMock();
    jsonConvertibleMock = JsonConvertibleMock();
    multipartFileProviderMock = MultipartFileProviderMock();
    clientMock = ClientMock();
    localStoreMock = LocalStoreMock();
    when(() => clientMock.put(fullPath, body: any(named: "body"), headers: any(named: "headers"))).thenAnswer((invocation) => Future.value(ResponseMock()));
    when(() => clientMock.post(fullPath, body: any(named: "body"), headers: any(named: "headers"))).thenAnswer((invocation) => Future.value(ResponseMock()));
    when(() => clientMock.get(fullPath, headers: any(named: "headers"))).thenAnswer((invocation) => Future.value(ResponseMock()));
    when(() => clientMock.delete(fullPath, headers: any(named: "headers"))).thenAnswer((invocation) => Future.value(ResponseMock()));

    registerFallbackValue(BaseRequestFake());

    ReferenceWrapper<ClientMock> refWrapper = ReferenceWrapper(clientMock);
    sut = Request(refWrapper, multipartFileProviderMock, localStoreMock, jsonWrapperMock);
  });

  group("formatHeaders method tests", () {
    test("only default headers", () {
      // Act
      final result =  sut.formatHeaders(null);

      // Assert
      expect(result, {
        "accept": "application/json",
        "content-type": "application/json"
      });
    });

    test("additional headers added", () {
      // Arrange
      const headers = { "authorization": "auth-token-here" };

      // Act
      final result =  sut.formatHeaders(headers);

      // Assert
      expect(result, {
        "accept": "application/json",
        "content-type": "application/json",
        "authorization": "auth-token-here"
      });
    });
  });

  group("put method tests", () {
    test("with headers", () async {
      // Arrange
      const headers = { "authorization": "auth-token-here" };
      when(() => jsonWrapperMock.encodeData(any())).thenAnswer((invocation) => '{"username": "username1"}');

      // Act
      await sut.put(path, jsonConvertibleMock, jsonWrapperMock, headers: headers);

      // Assert
      verify(() => clientMock.put(fullPath,
          body: '{"username": "username1"}',
          headers: {
            "accept": "application/json",
            "content-type": "application/json",
            "authorization": "auth-token-here"}
      )).called(1);
    });

    test("without headers", () async {
      // Arrange
      when(() => jsonWrapperMock.encodeData(any())).thenAnswer((invocation) => '{"username": "username1"}');

      // Act
      await sut.put(path, jsonConvertibleMock, jsonWrapperMock);

      // Assert
      verify(() => clientMock.put(fullPath,
          body: '{"username": "username1"}',
          headers: {
            "accept": "application/json",
            "content-type": "application/json"}
      )).called(1);
    });
  });

  group("post method tests", () {
    test("with headers", () async {
      // Arrange
      const headers = { "authorization": "auth-token-here" };
      when(() => jsonWrapperMock.encodeData(any())).thenAnswer((invocation) => '{"username": "username1"}');

      // Act
      await sut.post(path, jsonConvertibleMock, jsonWrapperMock, headers: headers);

      // Assert
      verify(() => clientMock.post(fullPath,
          body: '{"username": "username1"}',
          headers: {
            "accept": "application/json",
            "content-type": "application/json",
            "authorization": "auth-token-here"}
      )).called(1);
    });

    test("without headers", () async {
      // Arrange
      when(() => jsonWrapperMock.encodeData(any())).thenAnswer((invocation) => '{"username": "username1"}');

      // Act
      await sut.post(path, jsonConvertibleMock, jsonWrapperMock);

      // Assert
      verify(() => clientMock.post(fullPath,
          body: '{"username": "username1"}',
          headers: {
            "accept": "application/json",
            "content-type": "application/json"}
      )).called(1);
    });
  });

  group("postWithoutBody method tests", () {
    test("with headers", () async {
      // Arrange
      const headers = { "authorization": "auth-token-here" };

      // Act
      await sut.postWithoutBody(path, headers: headers);

      // Assert
      verify(() => clientMock.post(fullPath,
          headers: {
            "accept": "application/json",
            "content-type": "application/json",
            "authorization": "auth-token-here"}
      )).called(1);
    });

    test("without headers", () async {
      // Act
      await sut.postWithoutBody(path);

      // Assert
      verify(() => clientMock.post(fullPath,
          headers: {
            "accept": "application/json",
            "content-type": "application/json"}
      )).called(1);
    });
  });

  group("get method tests", () {
    test("with headers", () async {
      // Arrange
      const headers = { "authorization": "auth-token-here" };

      // Act
      await sut.get(path, headers: headers);

      // Assert
      verify(() => clientMock.get(fullPath,
          headers: {
            "accept": "application/json",
            "content-type": "application/json",
            "authorization": "auth-token-here"}
      )).called(1);
    });

    test("without headers", () async {
      // Act
      await sut.get(path);

      // Assert
      verify(() => clientMock.get(fullPath,
          headers: {
            "accept": "application/json",
            "content-type": "application/json"}
      )).called(1);
    });
  });

  group("delete method tests", () {
    test("with headers", () async {
      // Arrange
      const headers = { "authorization": "auth-token-here" };

      // Act
      await sut.delete(path, headers: headers);

      // Assert
      verify(() => clientMock.delete(fullPath,
          headers: {
            "accept": "application/json",
            "content-type": "application/json",
            "authorization": "auth-token-here"}
      )).called(1);
    });

    test("without headers", () async {
      // Act
      await sut.delete(path);

      // Assert
      verify(() => clientMock.delete(fullPath,
          headers: {
            "accept": "application/json",
            "content-type": "application/json"}
      )).called(1);
    });
  });

  group("fileUpload method tests", () {
    test("with baseUrl and filePath", () async {
      // Arrange
      when(() => clientMock.send(any())).thenAnswer((invocation) => Future.value(StreamedResponseMock()));
      when(() => multipartFileProviderMock.fromPath(any(), any())).thenAnswer((invocation) => Future.value(MultipartFileMock()));

      // Act
      final result = await sut.multipartRequest("POST", "/path",
          {"field1":"val1", "field2":"val2"}, baseUrl: "www.example.com",
          filePath: "/filePath");

      // Assert
      expect(result, isA<http.StreamedResponse>());
      verify(() => clientMock.send(any())).called(1);
    });

    test("without baseUrl and filePath", () async {
      // Arrange
      when(() => clientMock.send(any())).thenAnswer((invocation) => Future.value(StreamedResponseMock()));
      when(() => multipartFileProviderMock.fromPath(any(), any())).thenAnswer((invocation) => Future.value(MultipartFileMock()));

      // Act
      final result = await sut.multipartRequest("DELETE", "/path",
          {"field1":"val1", "field2":"val2"});

      // Assert
      expect(result, isA<http.StreamedResponse>());
      verify(() => clientMock.send(any())).called(1);
    });
  });
}