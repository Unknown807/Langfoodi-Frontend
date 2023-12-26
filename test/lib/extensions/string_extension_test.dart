
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_social_media/extensions/extensions.dart';

void main() {
  group("capitalise method tests", () {
    test("String is upper-cased", () {
      // Act
      final result = "lower".capitalise();

      // Assert
      expect(result, "Lower");
    });

    test("Single character string is upper-cased", () {
      // Act
      final result = "a".capitalise();

      // Assert
      expect(result, "A");
    });

    test("Empty string is upper-cased", () {
      // Act
      final result = "".capitalise();

      // Assert
      expect(result, "");
    });

    test("Number String is upper-cased", () {
      // Act
      final result = "123".capitalise();

      // Assert
      expect(result, "123");
    });
  });
}