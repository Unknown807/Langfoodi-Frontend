import 'package:cloudinary_url_gen/transformation/delivery/delivery_actions.dart';
import 'package:cloudinary_url_gen/transformation/resize/crop.dart';
import 'package:cloudinary_url_gen/transformation/transformation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_social_media/utilities/utilities.dart';

void main() {
  late ImageTransformationBuilder sut;

  setUp(() {
    sut = ImageTransformationBuilder();
  });

  group("getImageTransformation method tests", () {
    test("transformation type is none", () async {
      // Act
      final result = sut.getImageTransformation(ImageTransformationType.none);

      // Assert
      expect(result, isNull);
    });

    test("transformation type is tiny", () async {
      // Act
      final result = sut.getImageTransformation(ImageTransformationType.tiny);

      // Assert
      expect(result, isNotNull);
      expect(result, isA<Transformation>());
      expect(result!.components, [
        isA<Quality>(),
        isA<Thumbnail>(),
        isA<Dpr>()
      ]);
      expect((result!.components[1] as Thumbnail).dimensions.width, 50);
      expect((result!.components[1] as Thumbnail).dimensions.height, 50);
    });

    test("transformation type is lowVertical", () async {
      // Act
      final result = sut.getImageTransformation(ImageTransformationType.lowVertical);

      // Assert
      expect(result, isNotNull);
      expect(result, isA<Transformation>());
      expect(result!.components, [
        isA<Quality>(),
        isA<Thumbnail>(),
        isA<Dpr>()
      ]);
      expect((result!.components[1] as Thumbnail).dimensions.width, 200);
      expect((result!.components[1] as Thumbnail).dimensions.height, 300);
    });

    test("transformation type is lowHorizontal", () async {
      // Act
      final result = sut.getImageTransformation(ImageTransformationType.lowHorizontal);

      // Assert
      expect(result, isNotNull);
      expect(result, isA<Transformation>());
      expect(result!.components, [
        isA<Quality>(),
        isA<Thumbnail>(),
        isA<Dpr>()
      ]);
      expect((result!.components[1] as Thumbnail).dimensions.width, 250);
      expect((result!.components[1] as Thumbnail).dimensions.height, 150);
    });

    test("transformation type is standard", () async {
      // Act
      final result = sut.getImageTransformation(ImageTransformationType.standard);

      // Assert
      expect(result, isNotNull);
      expect(result, isA<Transformation>());
      expect(result!.components, [
        isA<Quality>(),
        isA<Thumbnail>(),
        isA<Dpr>()
      ]);
    });

    test("transformation type is high", () async {
      // Act
      final result = sut.getImageTransformation(ImageTransformationType.high);

      // Assert
      expect(result, isNotNull);
      expect(result, isA<Transformation>());
      expect(result!.components, [
        isA<Quality>(),
      ]);
    });
  });
}