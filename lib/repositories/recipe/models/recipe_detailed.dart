part of 'recipe_models.dart';

class RecipeDetailed extends Equatable {
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
  final List<String> ingredients;
  final List<String> recipeSteps;
  final DateTime creationDate;
  final DateTime lastUpdatedDate;

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
