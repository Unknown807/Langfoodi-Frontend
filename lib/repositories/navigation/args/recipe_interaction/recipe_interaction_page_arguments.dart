part 'recipe_interaction_type.dart';

class RecipeInteractionPageArguments {
  RecipeInteractionPageArguments({required this.pageType, this.recipeId});

  final RecipeInteractionType pageType;
  final String? recipeId;
}