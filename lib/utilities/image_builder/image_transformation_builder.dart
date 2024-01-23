part of 'package:recipe_social_media/utilities/utilities.dart';

class ImageTransformationBuilder {
  Transformation? getImageTransformation(ImageTransformationType type) {
    switch (type) {
      case ImageTransformationType.low:
        return _getLowQualityTransformation();
      case ImageTransformationType.standard:
        return _getStandardTransformation();
      case ImageTransformationType.high:
        return _getHighQualityTransformation();
      default:
        return null;
    }
  }
  
  Transformation _getLowQualityTransformation() {
    return Transformation()
      ..delivery(Quality(Quality.autoLow()))
      ..resize(Resize.thumbnail()..width(200)..height(300))
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