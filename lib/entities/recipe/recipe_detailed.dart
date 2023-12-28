part of 'recipe_entities.dart';

class RecipeDetailed extends Equatable with JsonConvertible {
  const RecipeDetailed(
    this.id,
    this.title,
    this.description,
    this.thumbnailId,
    this.chef,
    this.tags,
    this.ingredients,
    this.recipeSteps,
    this.cookingTime,
    this.kiloCalories,
    this.numberOfServings,
    this.servingQuantity,
    this.servingUnitOfMeasurement,
    this.creationDate,
    this.lastUpdatedDate
  );

  final String id;
  final String title;
  final String description;
  final String? thumbnailId;
  final UserAccount chef;
  final List<String> tags;
  final List<Ingredient> ingredients;
  final List<RecipeStep> recipeSteps;
  final Duration? cookingTime;
  final int? kiloCalories;
  final int? numberOfServings;
  final double? servingQuantity;
  final String? servingUnitOfMeasurement;
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
        jsonData["thumbnailId"],
        UserAccount.fromJson(jsonData["chef"]),
        (jsonData["tags"] as List).map((tag) => tag as String).toList(),
        jsonData["ingredients"].map<Ingredient>((i) => Ingredient.fromJson(i)).toList(),
        jsonData["recipeSteps"].map<RecipeStep>((r) => RecipeStep.fromJson(r)).toList(),
        jsonData["cookingTime"] != null ? Duration(seconds: jsonData["cookingTime"]) : null,
        jsonData["kiloCalories"],
        jsonData["numberOfServings"],
        jsonData["servingSize"] != null ? jsonData["servingSize"]["quantity"].toDouble() : null,
        jsonData["servingSize"] != null ? jsonData["servingSize"]["unitOfMeasurement"] : null,
        DateTime.parse(jsonData["creationDate"]),
        DateTime.parse(jsonData["lastUpdatedDate"])
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    thumbnailId,
    chef,
    tags,
    ingredients,
    recipeSteps,
    cookingTime,
    kiloCalories,
    numberOfServings,
    servingQuantity,
    servingUnitOfMeasurement,
    creationDate,
    lastUpdatedDate
  ];
}
