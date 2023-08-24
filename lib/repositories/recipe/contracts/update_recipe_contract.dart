part of 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';

class UpdateRecipeContract with JsonConvertible {
  UpdateRecipeContract({
    required this.id,
    required this.title,
    required this.description,
    required this.labels,
    required this.ingredients,
    required this.recipeSteps,
    this.cookingTime,
    this.calories,
    this.numberOfServings
  });

  final String id;
  final String title;
  final String description;
  final List<String> labels;
  final List<Ingredient> ingredients;
  final List<RecipeStep> recipeSteps;
  final Duration? cookingTime;
  final int? calories;
  final int? numberOfServings;

  @override
  Map toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "labels": labels,
      "ingredients": ingredients.map((i) => i.toJson()).toList(),
      "recipeSteps": recipeSteps.map((r) => r.toJson()).toList(),
      "cookingTime": cookingTime?.inSeconds,
      "calories": calories,
      "numberOfServings": numberOfServings
    };
  }
}