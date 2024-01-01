part of 'recipe_view_bloc.dart';

@immutable
sealed class RecipeViewEvent extends Equatable {
  const RecipeViewEvent();

  @override
  List<Object> get props => [];
}

final class ChangeRecipesToDisplay extends RecipeViewEvent {
  const ChangeRecipesToDisplay();
}

final class GoToEditRecipeAndExpectResult extends RecipeViewEvent {
  const GoToEditRecipeAndExpectResult(this.context, this.recipeId);

  final BuildContext context;
  final String recipeId;

  @override
  List<Object> get props => [context, recipeId];
}