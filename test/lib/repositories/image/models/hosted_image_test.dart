
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_social_media/repositories/image/image_repo.dart';

void main() {
  group("fromJson method tests", () {
    test("model returned", () {
      // Arrange
      final jsonData = {
        "public_id": "public id",
        "version": 12345,
        "secure_url": "www.example.com",
        "format": "png",
        "created_at": "2023-08-18",
        "width": 500,
        "height": 600
      };

      // Act
      final result = HostedImage.fromJson(jsonData);

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
}