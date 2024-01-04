part of 'package:recipe_social_media/utilities/utilities.dart';

class ImageBuilder {
  ImageBuilder(this.imageTransformationBuilder, this.fileSystem);

  final ImageTransformationBuilder imageTransformationBuilder;
  final FileSystem fileSystem;

  Widget decideOnAndDisplayImage({required String imageUrl,
    required Widget Function(BuildContext context, dynamic obj1, dynamic obj2) errorBuilder,
    BoxFit imageFit = BoxFit.cover, bool isAsset = false,
    ImageTransformationType transformationType = ImageTransformationType.none})
  {
    if (fileSystem.isFileSync(imageUrl) || imageUrl.endsWith(".png")) {
      if (isAsset) {
        return displayAssetImage(
          imagePath: imageUrl,
          errorBuilder: errorBuilder,
          imageFit: imageFit);
      } else {
        return displayLocalImage(
          imagePath: imageUrl,
          errorBuilder: errorBuilder,
          imageFit: imageFit);
      }
    }

    return displayCloudinaryImage(
      imageUrl: imageUrl,
      errorBuilder: errorBuilder,
      imageFit: imageFit,
      transformationType: transformationType);
  }

  Widget displayCloudinaryImage({required String imageUrl,
    required Widget Function(BuildContext context, String url, Object error) errorBuilder,
    BoxFit imageFit = BoxFit.cover, ImageTransformationType transformationType = ImageTransformationType.none})
  {
    return CldImageWidget(
      publicId: imageUrl,
      fit: imageFit,
      errorBuilder: errorBuilder,
      placeholder: (BuildContext context, String url) =>
        const Center(child: CircularProgressIndicator()),
      transformation: imageTransformationBuilder.getImageTransformation(transformationType),
    );
  }

  Widget displayAssetImage({required String imagePath,
    required Widget Function(BuildContext context, Object exception, StackTrace? stackTrace) errorBuilder,
    BoxFit imageFit = BoxFit.cover})
  {
    return Image.asset(
      imagePath,
      fit: imageFit,
      errorBuilder: errorBuilder);
  }

  Widget displayLocalImage({required String imagePath,
    required Widget Function(BuildContext context, Object exception, StackTrace? stackTrace) errorBuilder,
    BoxFit imageFit = BoxFit.cover})
  {
    return Image.file(
      fileSystem.file(imagePath),
      fit: imageFit,
      errorBuilder: errorBuilder);
  }
}