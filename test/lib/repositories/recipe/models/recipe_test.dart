import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';

void main() {
  group("Recipe model tests", () {
    group("fromJson method tests", () {
      test("json map is converted into model", () {
        // Arrange
        const data = {"id": "01","title": "title","description": "desc","labels":["lbl1"], "chefUsername": "chef1","creationDate": "2023-08-18", "lastUpdatedDate": "2023-08-18"};

        // Act
        final result = Recipe.fromJson(data);

        // Assert
        expect(result, Recipe("01", "title", "desc", "chef1", const ["lbl1"], null, null, null, DateTime.parse("2023-08-18"), DateTime.parse("2023-08-18")));
      });
    });
  });
}