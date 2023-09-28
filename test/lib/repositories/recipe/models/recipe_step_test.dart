import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';

void main() {
  group("recipe step model tests", () {
    group("toJson method tests", () {
      test("model to json map", () {
        // Arrange
        const model = RecipeStep("step1", "www.example.com/imgpath");

        // Act
        final result = model.toJson();

        // Assert
        expect(result, {
          "text": "step1",
          "imageUrl": "www.example.com/imgpath"
        });
      });
    });

    group("fromJson method tests", () {
      test("json map to recipe step model", () {
        // Arrange
        const data = {"text": "step1", "imageUrl": "www.example.com/imgpath"};

        // Act
        final result = RecipeStep.fromJson(data);

        // Assert
        expect(result, const RecipeStep("step1", "www.example.com/imgpath"));
      });
    });
  });
}