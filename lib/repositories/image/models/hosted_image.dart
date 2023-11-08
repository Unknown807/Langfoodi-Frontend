part of 'package:recipe_social_media/repositories/image/image_repo.dart';

class HostedImage extends Equatable with JsonConvertible {
  const HostedImage(
    this.publicId,
    this.version,
    this.secureUrl,
    this.format,
    this.createdAt,
    this.width,
    this.height
  );

  final String publicId;
  final String version;
  final String secureUrl;
  final String format;
  final DateTime createdAt;
  final int width;
  final int height;

  @override
  List<Object?> get props => [
    publicId, version, secureUrl,
    format, createdAt, width, height
  ];

  static HostedImage fromJsonStr(String jsonStr, JsonWrapper jsonWrapper) {
    return HostedImage.fromJson(jsonWrapper.decodeData(jsonStr));
  }

  static HostedImage fromJson(Map jsonData) {
    return HostedImage(
      jsonData["public_id"],
      jsonData["version"].toString(),
      jsonData["secure_url"],
      jsonData["format"],
      DateTime.parse(jsonData["created_at"]),
      jsonData["width"],
      jsonData["height"]
    );
  }
}