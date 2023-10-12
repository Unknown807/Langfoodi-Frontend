import 'package:equatable/equatable.dart';
import 'package:recipe_social_media/utilities/utilities.dart';

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
  List<Object?> get props => [publicId];

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