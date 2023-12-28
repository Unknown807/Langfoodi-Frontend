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
  });
}