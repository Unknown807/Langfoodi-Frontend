import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_social_media/utilities/utilities.dart';
import '../fakes/secure_storage_fake.dart';

//class FlutterSecureStorageMock extends Mock implements FlutterSecureStorage {}

void main() {
  late SecureStorageFake secureStorageFake;
  late LocalStore sut; // system under test

  setUp(() {
    secureStorageFake = SecureStorageFake();
    sut = LocalStore(secureStorageFake);
  });

  group("keyExists method tests", () {

  });

  group("getKey method tests", () {

  });

  group("setKey method tests", () {

  });

  group("deleteKey method tests", () {

  });

  // test("keyExists returns true", () async {
  //
  // });
  //
  // test("keyExists returns false", () async {
  //
  // });
}