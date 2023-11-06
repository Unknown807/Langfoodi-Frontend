part of 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';

class UpdateRecipeContract with JsonConvertible {
  UpdateRecipeContract({
    required this.id,
    required this.title,
    required this.description,
    required this.tags,
    required this.ingredients,
    required this.recipeSteps,
    this.thumbnailId,
    this.cookingTime,
    this.kiloCalories,
    this.numberOfServings
  });

  final String id;
  final String title;
  final String description;
  final List<String> tags;
  final List<Ingredient> ingredients;
  final List<RecipeStep> recipeSteps;
  final String? thumbnailId;
  final Duration? cookingTime;
  final int? kiloCalories;
  final int? numberOfServings;

  @override
  Map toJson() {
    return {
      "id": id,
      "thumbnailId": thumbnailId,
      "title": title,
      "description": description,
      "labels": tags,
      "ingredients": ingredients.map((i) => i.toJson()).toList(),
      "recipeSteps": recipeSteps.map((r) => r.toJson()).toList(),
      "cookingTime": cookingTime?.inSeconds,
      "kiloCalories": kiloCalories,
      "numberOfServings": numberOfServings
    };
  }
}