import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_social_media/utilities/utilities.dart';

void main() {
  late JsonWrapper sut; // system under test

  setUp(() {
    sut = JsonWrapper();
  });

  group("encodeData method tests", () {
    test("map data is encoded into json string", () async {
      // Arrange
      const data = {
        "key1": "value1",
        "key2": "value2"
      };

      // Act
      final result = sut.encodeData(data);

      // Assert
      expect(result, '{"key1":"value1","key2":"value2"}');
    });
  });

  group("decodeData method tests", () {
    test("map data is decoded into Map object", () async {
      // Arrange
      const data = '{"key1":"value1","key2":"value2"}';

      // Act
      final result = sut.decodeData(data);

      // Assert
      expect(result, {"key1":"value1","key2":"value2"});
    });
  });
}
