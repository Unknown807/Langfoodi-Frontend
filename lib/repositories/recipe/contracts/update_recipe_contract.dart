part of 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';

class UpdateRecipeContract with JsonConvertible {
  UpdateRecipeContract({
    required this.id,
    required this.title,
    required this.description,
    required this.labels,
    required this.ingredients,
    required this.recipeSteps
  });

  final String id;
  final String title;
  final String description;
  final List<String> labels;
  final List<Ingredient> ingredients;
  final List<RecipeStep> recipeSteps;

  @override
  Map toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "labels": labels,
      "ingredients": ingredients.map((i) => i.toJson()).toList(),
      "recipeSteps": recipeSteps.map((r) => r.toJson()).toList()
    };
  }
}