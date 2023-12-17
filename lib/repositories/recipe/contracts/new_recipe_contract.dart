part of 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';

class NewRecipeContract with JsonConvertible {
  NewRecipeContract({
    required this.title,
    required this.description,
    required this.chefId,
    required this.tags,
    required this.ingredients,
    required this.recipeSteps,
    this.thumbnailId,
    this.cookingTime,
    this.kiloCalories,
    this.numberOfServings,
    this.servingQuantity,
    this.servingUnitOfMeasurement
  });

  final String title;
  final String description;
  final String chefId;
  final List<String> tags;
  final List<Ingredient> ingredients;
  final List<RecipeStep> recipeSteps;
  final String? thumbnailId;
  final Duration? cookingTime;
  final int? kiloCalories;
  final int? numberOfServings;
  final double? servingQuantity;
  final String? servingUnitOfMeasurement;

  @override
  Map toJson() {
    return {
      "title": title,
      "description": description,
      "thumbnailId": thumbnailId,
      "chefId": chefId,
      "tags": tags,
      "ingredients": ingredients.map((i) => i.toJson()).toList(),
      "recipeSteps": recipeSteps.map((r) => r.toJson()).toList(),
      "cookingTime": cookingTime?.inSeconds,
      "kiloCalories": kiloCalories,
      "numberOfServings": numberOfServings,
      "servingSize": {
        "quantity": servingQuantity,
        "unitOfMeasurement": servingUnitOfMeasurement
      }
    };
  }
}