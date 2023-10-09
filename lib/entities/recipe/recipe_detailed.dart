part of 'recipe_entities.dart';

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
    this.kiloCalories,
    this.numberOfServings,
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
  final Duration? cookingTime;
  final int? kiloCalories;
  final int? numberOfServings;
  final DateTime creationDate;
  final DateTime lastUpdatedDate;

  static RecipeDetailed fromJsonStr(String jsonStr, JsonWrapper jsonWrapper) {
    return RecipeDetailed.fromJson(jsonWrapper.decodeData(jsonStr));
  }

  static RecipeDetailed fromJson(Map jsonData) {
    return RecipeDetailed(
        jsonData["id"],
        jsonData["title"],
        jsonData["description"],
        User.fromJson(jsonData["chef"]),
        (jsonData["labels"] as List).map((label) => label as String).toList(),
        jsonData["ingredients"].map<Ingredient>((i) => Ingredient.fromJson(i)).toList(),
        jsonData["recipeSteps"].map<RecipeStep>((r) => RecipeStep.fromJson(r)).toList(),
        jsonData["cookingTime"] != null ? Duration(seconds: jsonData["cookingTime"]) : null,
        jsonData["kiloCalories"],
        jsonData["numberOfServings"],
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
    kiloCalories,
    numberOfServings,
    creationDate,
    lastUpdatedDate
  ];
}
