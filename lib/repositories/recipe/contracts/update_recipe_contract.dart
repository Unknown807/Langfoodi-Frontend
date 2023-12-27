part of 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';

class UpdateRecipeContract with JsonConvertible {
  UpdateRecipeContract({
    required this.id,
    required this.title,
    required this.description,
    required this.tags,
    required this.ingredients,
    required this.recipeSteps,
    this.cookingTime,
    this.kiloCalories,
    this.numberOfServings,
    this.servingQuantity,
    this.servingUnitOfMeasurement,
    this.thumbnailId
  });

  final String id;
  final String title;
  final String description;
  final List<String> tags;
  final List<Ingredient> ingredients;
  final List<RecipeStep> recipeSteps;
  final Duration? cookingTime;
  final int? kiloCalories;
  final int? numberOfServings;
  final double? servingQuantity;
  final String? servingUnitOfMeasurement;
  final String? thumbnailId;

  @override
  Map toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "thumbnailId": thumbnailId,
      "tags": tags,
      "ingredients": ingredients.map((i) => i.toJson()).toList(),
      "recipeSteps": recipeSteps.map((r) => r.toJson()).toList(),
      "cookingTime": cookingTime?.inSeconds,
      "kiloCalories": kiloCalories,
      "numberOfServings": numberOfServings,
      "servingSize": servingQuantity == null || servingUnitOfMeasurement == null
          ? null
          : { "quantity": servingQuantity, "unitOfMeasurement": servingUnitOfMeasurement }
    };
  }
}