import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_social_media/repositories/image/image_repo.dart';
import '../../../../test_utilities/mocks/generic_mocks.dart';

void main() {
  late ImageRepository sut;
  late CloudinaryMock cloudinaryMock;
  late CloudinaryConfigMock cloudinaryConfigMock;
  late CloudConfigMock cloudConfigMock;
  late RequestMock requestMock;
  late ResponseMock responseMock;
  late StreamedResponseMock streamedResponseMock;
  late JsonWrapperMock jsonWrapperMock;

  setUp(() {
    cloudinaryMock = CloudinaryMock();
    cloudinaryConfigMock = CloudinaryConfigMock();
    cloudConfigMock = CloudConfigMock();
    requestMock = RequestMock();
    responseMock = ResponseMock();
    streamedResponseMock = StreamedResponseMock();
    jsonWrapperMock = JsonWrapperMock();

    when(() => requestMock.currentToken).thenAnswer((invocation) async => "test_token");
    when(() => cloudinaryMock.config).thenReturn(cloudinaryConfigMock);
    when(() => cloudinaryConfigMock.cloudConfig).thenReturn(cloudConfigMock);
    when(() => cloudConfigMock.cloudName).thenReturn("cloud name");
    when(() => cloudConfigMock.apiKey).thenReturn("api key");

    sut = ImageRepository(requestMock, jsonWrapperMock, cloudinaryMock);
  });

  group("getSignature method tests", () {
    test("success, returns signature model", () async {
      // Arrange
      when(() => requestMock.postWithoutBody(any(), headers: any(named: "headers"))).thenAnswer((invocation) => Future.value(responseMock));
      when(() => responseMock.statusCode).thenReturn(200);
      when(() => responseMock.body).thenReturn('{"signature": "sig", "timeStamp": 12345 }');
      when(() => jsonWrapperMock.decodeData(any()))
          .thenReturn({"signature": "sig", "timeStamp": 12345 });

      // Act
      final result = await sut.getSignature();

      // Assert
      expect(result, const Signature("sig", "12345"));
      verify(() => requestMock.postWithoutBody("/image/get/cloudinary-signature", headers: any(named: "headers"))).called(1);
    });

    test("unsuccessful, call returns null", () async {
      // Arrange
      when(() => requestMock.postWithoutBody(any(), headers: any(named: "headers"))).thenAnswer((invocation) => Future.value(responseMock));
      when(() => responseMock.statusCode).thenReturn(401);

      // Act
      final result = await sut.getSignature();

      // Assert
      expect(result, isNull);
      verify(() => requestMock.postWithoutBody("/image/get/cloudinary-signature", headers: any(named: "headers"))).called(1);
    });
  });

  group("uploadImage method tests", () {
    test("unsuccessful upload, return null hosted image", () async {
      // Arrange
      final contract = SignedUploadContract("sig", "12345");
      when(() => requestMock.multipartRequest("POST", any(), any(), filePath: any(named: "filePath"), baseUrl: any(named: "baseUrl")))
        .thenAnswer((invocation) => Future.value(streamedResponseMock));
      when(() => streamedResponseMock.statusCode).thenReturn(401);

      // Act
      final result = await sut.uploadImage("path", contract);

      // Assert
      expect(result, isNull);
    });

    test("successful upload, return hosted image model", () async {
      // Arrange
      final contract = SignedUploadContract("sig", "12345");
      when(() => requestMock.multipartRequest("POST", any(), any(), filePath: any(named: "filePath"), baseUrl: any(named: "baseUrl")))
          .thenAnswer((invocation) => Future.value(streamedResponseMock));

      final byteStreamMock = ByteStreamMock();
      when(() => streamedResponseMock.statusCode).thenReturn(200);
      when(() => streamedResponseMock.stream).thenAnswer((invocation) => byteStreamMock);
      when(() => byteStreamMock.toBytes())
          .thenAnswer((invocation) => Future.value(Uint8List.fromList([104,101,108,108,111])));
      when(() => jsonWrapperMock.decodeData("hello"))
          .thenReturn({
            "public_id": "public id",
            "version": 12345,
            "secure_url": "www.example.com",
            "format": "png",
            "created_at": "2023-08-18",
            "width": 500,
            "height": 600
          });

      // Act
      final result = (await sut.uploadImage("path", contract))!;

      // Assert
      expect(result.publicId, "public id");
      expect(result.version, "12345");
      expect(result.secureUrl, "www.example.com");
      expect(result.format, "png");
      expect(result.createdAt, DateTime.parse("2023-08-18"));
      expect(result.width, 500);
      expect(result.height, 600);
    });
  });

  group("removeImages method tests", () {
    test("unsuccessful response, so return false", () async {
      // Arrange
      when(() => responseMock.statusCode).thenReturn(500);
      when(() => requestMock.delete("/image/bulk-delete?publicIds=1&publicIds=2&publicIds=3", headers: any(named: "headers")))
        .thenAnswer((invocation) => Future.value(responseMock));

      // Act
      final result = await sut.removeImages(["1", "2", "3"]);

      // Assert
      expect(result, false);
      verify(() => requestMock.delete("/image/bulk-delete?publicIds=1&publicIds=2&publicIds=3", headers: any(named: "headers"))).called(1);
    });

    test("successful response, so return true", () async {
      // Arrange
      when(() => responseMock.statusCode).thenReturn(200);
      when(() => requestMock.delete("/image/bulk-delete?publicIds=1&publicIds=2&publicIds=3", headers: any(named: "headers")))
          .thenAnswer((invocation) => Future.value(responseMock));

      // Act
      final result = await sut.removeImages(["1", "2", "3"]);

      // Assert
      expect(result, true);
      verify(() => requestMock.delete("/image/bulk-delete?publicIds=1&publicIds=2&publicIds=3", headers: any(named: "headers"))).called(1);
    });
  });
  
  group("removeImage method tests", () {
    test("unsuccessful response, so return false", () async {
      // Arrange
      when(() => responseMock.statusCode).thenReturn(401);
      when(() => requestMock.delete("/image/single-delete?publicId=publicidwow", headers: any(named: "headers")))
        .thenAnswer((invocation) => Future.value(responseMock));

      // Act
      final result = await sut.removeImage("publicidwow");

      // Assert
      expect(result, false);
      verify(() => requestMock.delete("/image/single-delete?publicId=publicidwow", headers: any(named: "headers"))).called(1);
    });

    test("successful response, so return true", () async {
      // Arrange
      when(() => responseMock.statusCode).thenReturn(200);
      when(() => requestMock.delete("/image/single-delete?publicId=publicidwow", headers: any(named: "headers")))
          .thenAnswer((invocation) => Future.value(responseMock));

      // Act
      final result = await sut.removeImage("publicidwow");

      // Assert
      expect(result, true);
      verify(() => requestMock.delete("/image/single-delete?publicId=publicidwow", headers: any(named: "headers"))).called(1);
    });
  });
}