import 'dart:math';

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:cloudinary_flutter/image/cld_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_social_media/utilities/utilities.dart';
import '../../../../test_utilities/mocks/generic_mocks.dart';

void main() {
  late CloudinaryMock cloudinaryMock;
  late CloudinaryConfigMock cloudinaryConfigMock;
  late CloudConfigMock cloudConfigMock;
  late FileSystemMock fileSystemMock;
  late ImageTransformationBuilderMock imageTransformationBuilderMock;
  late ImageBuilder sut;

  errorBuilderStub(BuildContext context, obj1, obj2) {
    return const Text("Error Widget");
  }

  setUp(() {
    cloudinaryMock = CloudinaryMock();
    cloudinaryConfigMock = CloudinaryConfigMock();
    cloudConfigMock = CloudConfigMock();
    fileSystemMock = FileSystemMock();
    imageTransformationBuilderMock = ImageTransformationBuilderMock();

    when(() => fileSystemMock.file(any())).thenReturn(FileMock());
    when(() => imageTransformationBuilderMock.getImageTransformation(ImageTransformationType.none)).thenReturn(null);
    when(() => cloudinaryMock.config).thenReturn(cloudinaryConfigMock);
    when(() => cloudinaryConfigMock.cloudConfig).thenReturn(cloudConfigMock);
    when(() => cloudConfigMock.cloudName).thenReturn("cloud name");
    when(() => cloudConfigMock.apiKey).thenReturn("api key");
    when(() => cloudinaryMock.image(any())).thenReturn(CldImageMock());
    CloudinaryContext.cloudinary = cloudinaryMock;

    sut = ImageBuilder(imageTransformationBuilderMock, fileSystemMock);
  });

  group("decideOnAndDisplayImage method tests", () {
    test("imageUrl is a local file, so return FileImage widget", () async {
      // Arrange
      when(() => fileSystemMock.isFileSync(any())).thenReturn(true);

      // Act
      final result = sut.decideOnAndDisplayImage(imageUrl: "./image.png", errorBuilder: errorBuilderStub);

      // Assert
      expect(result, isNotNull);
      expect(result, isA<Image>());
      expect((result as Image).image, isA<FileImage>());
    });

    test("imageUrl is a local asset file, isAsset is true, so return AssetImage widget", () async {
      // Arrange
      when(() => fileSystemMock.isFileSync(any())).thenReturn(true);

      // Act
      final result = sut.decideOnAndDisplayImage(
        isAsset: true,
        imageUrl: "./image.png",
        errorBuilder: errorBuilderStub
      );

      // Assert
      expect(result, isNotNull);
      expect(result, isA<Image>());
      expect((result as Image).image, isA<AssetImage>());
    });

    test("imageUrl is a cloudinary id, so return CldImageWidget", () async {
      // Arrange
      when(() => fileSystemMock.isFileSync(any())).thenReturn(false);

      // Act
      final result = sut.decideOnAndDisplayImage(imageUrl: "id12345", errorBuilder: errorBuilderStub);

      // Assert
      expect(result, isNotNull);
      expect(result, isA<CldImageWidget>());
    });
  });

  group("displayCloudinaryImage method tests", () {
    test("Cloudinary Image Widget is returned", () async {
      // Act
      final result = sut.displayCloudinaryImage(imageUrl: "publicId", errorBuilder: errorBuilderStub);

      // Assert
      expect(result, isNotNull);
      expect(result, isA<CldImageWidget>());
    });
  });

  group("displayAssetImage method tests", () {
    test("Image is returned", () async {
      // Act
      final result = sut.displayAssetImage(imagePath: "./image.png", errorBuilder: errorBuilderStub);

      // Assert
      expect(result, isNotNull);
      expect(result, isA<Image>());
      expect((result as Image).image, isA<AssetImage>());
    });
  });

  group("displayLocalImage method tests", () {
    test("Image is returned", () async {
      // Act
      final result = sut.displayLocalImage(imagePath: "./image.png", errorBuilder: errorBuilderStub);

      // Assert
      expect(result, isNotNull);
      expect(result, isA<Image>());
      expect((result as Image).image, isA<FileImage>());
    });
  });
}