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

    when(() => cloudinaryMock.config).thenReturn(cloudinaryConfigMock);
    when(() => cloudinaryConfigMock.cloudConfig).thenReturn(cloudConfigMock);
    when(() => cloudConfigMock.cloudName).thenReturn("cloud name");
    when(() => cloudConfigMock.apiKey).thenReturn("api key");

    sut = ImageRepository(requestMock, jsonWrapperMock, cloudinaryMock);
  });

  group("getSignature method tests", () {
    test("no public id, returns successful signature model", () async {
      // Arrange
      when(() => requestMock.postWithoutBody(any())).thenAnswer((invocation) => Future.value(responseMock));
      when(() => responseMock.statusCode).thenReturn(200);
      when(() => responseMock.body).thenReturn('{"signature": "sig", "timeStamp": 12345 }');
      when(() => jsonWrapperMock.decodeData(any()))
          .thenReturn({"signature": "sig", "timeStamp": 12345 });

      // Act
      final result = await sut.getSignature();

      // Assert
      expect(result, const Signature("sig", "12345"));
      verify(() => requestMock.postWithoutBody("/auth/get/cloudinary-signature")).called(1);
    });

    test("no public id, unsuccessful call returns null", () async {
      // Arrange
      when(() => requestMock.postWithoutBody(any())).thenAnswer((invocation) => Future.value(responseMock));
      when(() => responseMock.statusCode).thenReturn(401);

      // Act
      final result = await sut.getSignature();

      // Assert
      expect(result, isNull);
      verify(() => requestMock.postWithoutBody("/auth/get/cloudinary-signature")).called(1);
    });

    test("with public id, returns successful signature model", () async {
      // Arrange
      when(() => requestMock.postWithoutBody(any())).thenAnswer((invocation) => Future.value(responseMock));
      when(() => responseMock.statusCode).thenReturn(200);
      when(() => responseMock.body).thenReturn('{"signature": "sig", "timeStamp": 12345 }');
      when(() => jsonWrapperMock.decodeData(any()))
          .thenReturn({"signature": "sig", "timeStamp": 12345 });

      // Act
      final result = await sut.getSignature(publicId: "publicidhere");

      // Assert
      expect(result, const Signature("sig", "12345"));
      verify(() => requestMock.postWithoutBody("/auth/get/cloudinary-signature?publicId=publicidhere")).called(1);
    });

    test("with public id, unsuccessful call returns null", () async {
      // Arrange
      when(() => requestMock.postWithoutBody(any())).thenAnswer((invocation) => Future.value(responseMock));
      when(() => responseMock.statusCode).thenReturn(401);

      // Act
      final result = await sut.getSignature(publicId: "publicidhere");

      // Assert
      expect(result, isNull);
      verify(() => requestMock.postWithoutBody("/auth/get/cloudinary-signature?publicId=publicidhere")).called(1);
    });
  });

  group("uploadImage method tests", () {
    test("signature is null so return null hosted image", () async {
      // Arrange
      when(() => requestMock.postWithoutBody(any())).thenAnswer((invocation) => Future.value(responseMock));
      when(() => responseMock.statusCode).thenReturn(401);

      // Act
      final result = await sut.uploadImage("path");

      // Assert
      expect(result, isNull);
    });

    test("valid signature, unsuccessful upload, return null hosted image", () async {
      // Arrange
      when(() => requestMock.postWithoutBody(any())).thenAnswer((invocation) => Future.value(responseMock));
      when(() => responseMock.statusCode).thenReturn(200);
      when(() => responseMock.body).thenReturn('{"signature": "sig", "timeStamp": 12345 }');
      when(() => jsonWrapperMock.decodeData(any()))
          .thenReturn({"signature": "sig", "timeStamp": 12345 });
      when(() => requestMock.fileUpload(any(), any(), any(), baseUrl: any(named: "baseUrl")))
        .thenAnswer((invocation) => Future.value(streamedResponseMock));
      when(() => streamedResponseMock.statusCode).thenReturn(401);

      // Act
      final result = await sut.uploadImage("path");

      // Assert
      expect(result, isNull);
    });

    test("valid signature, successful upload, return hosted image model", () async {
      // Arrange
      when(() => requestMock.postWithoutBody(any())).thenAnswer((invocation) => Future.value(responseMock));
      when(() => responseMock.statusCode).thenReturn(200);
      when(() => responseMock.body).thenReturn('{"signature": "sig", "timeStamp": 12345 }');
      when(() => jsonWrapperMock.decodeData('{"signature": "sig", "timeStamp": 12345 }'))
          .thenReturn({"signature": "sig", "timeStamp": 12345 });
      when(() => requestMock.fileUpload(any(), any(), any(), baseUrl: any(named: "baseUrl")))
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
      final result = (await sut.uploadImage("path"))!;

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

  group("removeImage method tests", () {
    test("signature is null so return false", () async {
      // Arrange
      when(() => requestMock.postWithoutBody(any())).thenAnswer((invocation) => Future.value(responseMock));
      when(() => responseMock.statusCode).thenReturn(401);

      // Act
      final result = await sut.removeImage("public id");

      // Assert
      expect(result, false);
    });

    test("valid signature, unsuccessful response so return false", () async {
      // Arrange
      when(() => requestMock.postWithoutBody(any()))
          .thenAnswer((invocation) => Future.value(responseMock));
      when(() => responseMock.statusCode).thenReturn(200);
      when(() => responseMock.body).thenReturn('{"signature": "sig", "timeStamp": 12345 }');
      when(() => jsonWrapperMock.decodeData(any()))
          .thenReturn({"signature": "sig", "timeStamp": 12345 });

      final removeImageResponseMock = ResponseMock();
      when(() => requestMock.postWithoutBody("/v1_1/cloud name/image/destroy?public_id=publicidwow&api_key=api key&signature=sig&timestamp=12345", baseUrl: any(named: "baseUrl")))
        .thenAnswer((invocation) => Future.value(removeImageResponseMock));
      when(() => removeImageResponseMock.statusCode).thenReturn(401);

      // Act
      final result = await sut.removeImage("publicidwow");

      // Assert
      expect(result, false);
      verify(() => requestMock.postWithoutBody("/v1_1/cloud name/image/destroy?public_id=publicidwow&api_key=api key&signature=sig&timestamp=12345",
          baseUrl: any(named: "baseUrl"))).called(1);
    });

    test("valid signature, successful response so return true", () async {
      // Arrange
      when(() => requestMock.postWithoutBody(any()))
          .thenAnswer((invocation) => Future.value(responseMock));
      when(() => responseMock.statusCode).thenReturn(200);
      when(() => responseMock.body).thenReturn('{"signature": "sig", "timeStamp": 12345 }');
      when(() => jsonWrapperMock.decodeData(any()))
          .thenReturn({"signature": "sig", "timeStamp": 12345 });

      final removeImageResponseMock = ResponseMock();
      when(() => requestMock.postWithoutBody("/v1_1/cloud name/image/destroy?public_id=publicidwow&api_key=api key&signature=sig&timestamp=12345", baseUrl: any(named: "baseUrl")))
          .thenAnswer((invocation) => Future.value(removeImageResponseMock));
      when(() => removeImageResponseMock.statusCode).thenReturn(200);

      // Act
      final result = await sut.removeImage("publicidwow");

      // Assert
      expect(result, true);
      verify(() => requestMock.postWithoutBody("/v1_1/cloud name/image/destroy?public_id=publicidwow&api_key=api key&signature=sig&timestamp=12345",
          baseUrl: any(named: "baseUrl"))).called(1);
    });
  });
}