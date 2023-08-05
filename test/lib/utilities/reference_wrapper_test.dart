import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_social_media/utilities/utilities.dart';

void main() {

  group("getInstance method tests", () {
    test("matching instance", () {
      // Arrange
      Object obj = Object();
      ReferenceWrapper<Object> wrappedObj = ReferenceWrapper(obj);

      // Act
      Object unwrappedObj = wrappedObj.getInstance();

      // Assert
      expect(identical(obj, unwrappedObj), true);
    });
  });

  group("setInstance method tests", () {
    test("matching instance", () {
      // Arrange
      Object obj1 = Object();
      Object obj2 = Object();
      ReferenceWrapper<Object> wrappedObj = ReferenceWrapper(obj1);

      // Act
      wrappedObj.setInstance(obj2);
      Object unwrappedObj = wrappedObj.getInstance();

      // Assert
      expect(identical(obj1, unwrappedObj), false);
      expect(identical(obj2, unwrappedObj), true);
    });
  });

}