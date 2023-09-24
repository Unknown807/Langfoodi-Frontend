part of 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';

class Recipe extends Equatable with JsonConvertible {
  const Recipe(
      this.id,
      this.title,
      this.description,
      this.chefUsername,
      this.labels,
      this.cookingTime,
      this.kiloCalories,
      this.numberOfServings,
      this.creationDate,
      this.lastUpdatedDate);

  final String id;
  final String title;
  final String description;
  final String chefUsername;
  final List<String>? labels;
  final Duration? cookingTime;
  final int? kiloCalories;
  final int? numberOfServings;
  final DateTime creationDate;
  final DateTime lastUpdatedDate;

  static Recipe fromJson(Map jsonData, JsonWrapper jsonWrapper) {
    return Recipe(
      jsonData["id"],
      jsonData["title"],
      jsonData["description"],
      jsonData["chefUsername"],
      jsonData["labels"],
      jsonData["cookingTime"] != null ? Duration(seconds: jsonData["cookingTime"]) : null,
      jsonData["kiloCalories"] != null ? int.parse(jsonData["kiloCalories"]) : null,
      jsonData["numberOfServings"] != null ? int.parse(jsonData["numberOfServings"]) : null,
      DateTime.parse(jsonData["creationDate"]),
      DateTime.parse(jsonData["lastUpdatedDate"])
    );
  }

  @override
  List<Object?> get props =>
  [
    id,
    title,
    description,
    chefUsername,
    labels,
    cookingTime,
    kiloCalories,
    numberOfServings,
    creationDate,
    lastUpdatedDate
  ];
}
