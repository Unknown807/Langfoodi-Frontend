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
    this.cookingTime,
    this.calories,
    this.numberOfServings,
    this.creationDate,
    this.lastUpdatedDate
  );

  final String id;
  final String title;
  final String description;
  final User chef;
  final List<String>? labels;
  final List<Ingredient> ingredients;
  final List<RecipeStep> recipeSteps;
  final Duration? cookingTime;
  final int? calories;
  final int? numberOfServings;
  final DateTime creationDate;
  final DateTime lastUpdatedDate;

  static RecipeDetailed fromJsonStr(String jsonStr, JsonWrapper jsonWrapper) {
    return RecipeDetailed.fromJson(jsonWrapper.decodeData(jsonStr), jsonWrapper);
  }

  static RecipeDetailed fromJson(Map jsonData, JsonWrapper jsonWrapper) {
    return RecipeDetailed(
        jsonData["id"],
        jsonData["title"],
        jsonData["description"],
        User.fromJson(jsonData["chef"], jsonWrapper),
        jsonData["labels"],
        jsonData["ingredients"].map<Ingredient>((i) => Ingredient.fromJson(i, jsonWrapper)).toList(),
        jsonData["recipeSteps"].map<RecipeStep>((r) => RecipeStep.fromJson(r, jsonWrapper)).toList(),
        jsonData["cookingTime"] != null ? Duration(seconds: jsonData["cookingTime"]) : null,
        jsonData["calories"] != null ? int.parse(jsonData["calories"]) : null,
        jsonData["numberOfServings"] != null ? int.parse(jsonData["numberOfServings"]) : null,
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
    cookingTime,
    calories,
    numberOfServings,
    creationDate,
    lastUpdatedDate
  ];
}
