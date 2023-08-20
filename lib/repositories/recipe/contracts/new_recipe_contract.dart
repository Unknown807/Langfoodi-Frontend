part of 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';

class NewRecipeContract with JsonConvertible {
  NewRecipeContract({
    required this.title,
    required this.description,
    required this.chefId,
    required this.labels,
    required this.ingredients,
    required this.recipeSteps
  });

  final String title;
  final String description;
  final String chefId;
  final List<String> labels;
  final List<Ingredient> ingredients;
  final List<RecipeStep> recipeSteps;

  @override
  Map toJson() {
    return {
      "title": title,
      "description": description,
      "chefId": chefId,
      "labels": labels,
      "ingredients": ingredients.map((i) => i.toJson()).toList(),
      "recipeSteps": recipeSteps.map((r) => r.toJson()).toList()
    };
  }
}