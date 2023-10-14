import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_social_media/repositories/image/image_repo.dart';

void main() {
  group("toJson method tests", () {
    test("map returned", () {
      // Arrange
      var contract = SignedUploadContract("signature", "api key", "time stamp");

      // Act
      var result = contract.toJson();

      // Assert
      expect(result, {
        "api_key": "api key",
        "signature": "signature",
        "timestamp": "time stamp"
      });
    });
  });
}