part of 'package:recipe_social_media/utilities/utilities.dart';

class ImageTransformationBuilder {
  Transformation? getImageTransformation(ImageTransformationType type) {
    switch (type) {
      case ImageTransformationType.standard:
        return _getStandardTransformation();
      default:
        return null;
    }
  }

  Transformation _getStandardTransformation() {
    return Transformation()
      ..delivery(Quality(Quality.auto()))
      ..resize(Resize.thumbnail()..width(500))
      ..delivery(Dpr(Dpr.auto));
  }
}