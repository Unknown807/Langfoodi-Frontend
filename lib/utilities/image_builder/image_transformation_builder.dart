part of 'package:recipe_social_media/utilities/utilities.dart';

class ImageTransformationBuilder {
  Transformation? getImageTransformation(ImageTransformationType type) {
    switch (type) {
      case ImageTransformationType.tiny:
        return _getTinyQualityTransformation();
      case ImageTransformationType.lowVertical:
        return _getLowQualityVerticalTransformation();
      case ImageTransformationType.lowHorizontal:
        return _getLowQualityHorizontalTransformation();
      case ImageTransformationType.standard:
        return _getStandardTransformation();
      case ImageTransformationType.high:
        return _getHighQualityTransformation();
      default:
        return null;
    }
  }

  Transformation _getTinyQualityTransformation() {
    return _getLowOrTinyQualityTransformation(50, 50);
  }

  Transformation _getLowQualityVerticalTransformation() {
    return _getLowOrTinyQualityTransformation(200, 300);
  }

  Transformation _getLowQualityHorizontalTransformation() {
    return _getLowOrTinyQualityTransformation(250, 150);
  }

  Transformation _getLowOrTinyQualityTransformation(int width, int height) {
    return Transformation()
      ..delivery(Quality(Quality.autoLow()))
      ..resize(Resize.thumbnail()..width(width)..height(height))
      ..delivery(Dpr(Dpr.auto));
  }

  Transformation _getStandardTransformation() {
    return Transformation()
      ..delivery(Quality(Quality.auto()))
      ..resize(Resize.thumbnail()..width(500))
      ..delivery(Dpr(Dpr.auto));
  }
  
  Transformation _getHighQualityTransformation() {
    return Transformation()
        ..delivery(Quality(Quality.autoBest()));
  }
}