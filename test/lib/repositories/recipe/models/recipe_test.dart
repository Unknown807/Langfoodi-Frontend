import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';
import '../../../../../test_utilities/mocks/generic_mocks.dart';

void main() {
  late JsonWrapperMock jsonWrapperMock;

  setUp(() {
    jsonWrapperMock = JsonWrapperMock();
  });

  group("Recipe model tests", () {
    group("fromJson method tests", () {
      test("json map is converted into model", () {
        // Arrange
        const data = {"id": "01","title": "title","description": "desc","chefUsername": "chef1","creationDate": "2023-08-18"};

        // Act
        final result = Recipe.fromJson(data, jsonWrapperMock);

        // Assert
        expect(result, Recipe("01", "title", "desc", "chef1", DateTime.parse("2023-08-18")));
      });
    });
  });
}