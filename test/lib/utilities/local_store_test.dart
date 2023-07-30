import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_social_media/utilities/utilities.dart';
import '../../../test_utilities/fakes/secure_storage_fake.dart';

void main() {
  late SecureStorageFake secureStorageFake;
  late LocalStore sut; // system under test

  setUp(() {
    secureStorageFake = SecureStorageFake();
    sut = LocalStore(secureStorageFake);
  });

  group("keyExists method tests", () {
    test("keyExists returns true", () async {
      // Arrange
      await secureStorageFake.write(key: "test-key", value: "test-value");

      // Act
      final result = await sut.keyExists("test-key");

      // Assert
      expect(result, true);
    });

    test("keyExists returns false", () async {
      // Act
      final result = await sut.keyExists("test-key");

      // Assert
      expect(result, false);
    });
  });

  group("getKey method tests", () {
    test("key exists", () async {
      // Arrange
      await secureStorageFake.write(key: "test-key", value: "test-value");

      // Act
      final result = await sut.getKey("test-key");

      // Assert
      expect(result, "test-value");
    });

    test("key doesn't exist", () async {
      // Act
      final result = await sut.getKey("test-key");

      // Assert
      expect(result, "");
    });
  });

  group("setKey method tests", () {
    test("key exists after setting", () async {
      // Act
      sut.setKey("test-key", "test-value");
      final result = await secureStorageFake.read(key: "test-key");

      // Assert
      expect(result, "test-value");
    });
  });

  group("deleteKey method tests", () {
    test("key no longer exists", () async {
      // Arrange
      await secureStorageFake.write(key: "test-key", value: "test-value");

      // Act
      sut.deleteKey("test-key");
      final result = await secureStorageFake.read(key: "test-key");

      // Assert
      expect(result, null);
    });
  });
}