part of 'recipe_entities.dart';

class Recipe extends Equatable with JsonConvertible {
  const Recipe(
    this.id,
    this.title,
    this.description,
    this.thumbnailId,
    this.chefUsername,
    this.tags,
    this.cookingTime,
    this.kiloCalories,
    this.numberOfServings,
    this.creationDate,
    this.lastUpdatedDate
  );

  final String id;
  final String title;
  final String description;
  final String? thumbnailId;
  final String chefUsername;
  final List<String> tags;
  final Duration? cookingTime;
  final int? kiloCalories;
  final int? numberOfServings;
  final DateTime creationDate;
  final DateTime lastUpdatedDate;

  static Recipe fromJson(Map jsonData) {
    return Recipe(
      jsonData["id"],
      jsonData["title"],
      jsonData["description"],
      jsonData["thumbnailId"],
      jsonData["chefUsername"],
      (jsonData["tags"] as List).map((tag) => tag as String).toList(),
      jsonData["cookingTime"] != null ? Duration(seconds: jsonData["cookingTime"]) : null,
      jsonData["kiloCalories"],
      jsonData["numberOfServings"],
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
    thumbnailId,
    chefUsername,
    tags,
    cookingTime,
    kiloCalories,
    numberOfServings,
    creationDate,
    lastUpdatedDate
  ];
}
