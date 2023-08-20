part of 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';

class RecipeDetailed extends Equatable with JsonConvertible {
  const RecipeDetailed(
    this.id,
    this.title,
    this.description,
    this.chef,
    this.labels,
    this.ingredients,
    this.recipeSteps,
    this.creationDate,
    this.lastUpdatedDate
  );

  final String id;
  final String title;
  final String description;
  final User chef;
  final List<String> labels;
  final List<Ingredient> ingredients;
  final List<RecipeStep> recipeSteps;
  final DateTime creationDate;
  final DateTime lastUpdatedDate;

  static RecipeDetailed fromJson(String jsonStr, JsonWrapper jsonWrapper) {
    Map jsonData = jsonWrapper.decodeData(jsonStr);
    return RecipeDetailed(
        jsonData["id"],
        jsonData["title"],
        jsonData["description"],
        User.fromJson(jsonData["chef"], jsonWrapper),
        jsonData["labels"],
        jsonData["ingredients"].map((i) => Ingredient.fromJson(i, jsonWrapper)).toList(),
        jsonData["recipeSteps"].map((r) => RecipeStep.fromJson(r, jsonWrapper)).toList(),
        DateTime.parse(jsonData["creationDate"]),
        DateTime.parse(jsonData["lastUpdatedDate"])
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    chef,
    labels,
    ingredients,
    recipeSteps,
    creationDate,
    lastUpdatedDate
  ];
}
