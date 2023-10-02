import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';

void main() {
  group("toJson method tests", () {
    test("contract to map", () {
      // Arrange
      final contract = NewRecipeContract(
        title: "title",
        description: "desc",
        chefId: "chef1",
        labels: ["lbl1", "lbl2"],
        ingredients: const [Ingredient("eggs", 12.0, "whole")],
        recipeSteps: const [RecipeStep("step1", "www.example.com/image")],
      );

      // Act
      final result = contract.toJson();

      // Assert
      expect(result, {
        "title": "title",
        "description": "desc",
        "chefId": "chef1",
        "labels": ["lbl1", "lbl2"],
        "ingredients": [{"name": "eggs", "quantity": 12.0, "unitOfMeasurement": "whole"}],
        "recipeSteps": [{"text": "step1", "imageUrl": "www.example.com/image"}],
        "cookingTime": null,
        "kiloCalories": null,
        "numberOfServings": null
      });
    });
  });
}