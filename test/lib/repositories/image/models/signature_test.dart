import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_social_media/repositories/image/image_repo.dart';

void main() {
  group("fromJson method tests", () {
    test("model returned", () {
      // Arrange
      final jsonData = {
        "signature": "signature",
        "timeStamp": 12345678
      };

      // Act
      final result = Signature.fromJson(jsonData);

      // Assert
      expect(result.signature, "signature");
      expect(result.timeStamp, "12345678");
    });
  });
}