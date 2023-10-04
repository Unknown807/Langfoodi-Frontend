part of 'recipe_view_bloc.dart';

@immutable
sealed class RecipeViewPageEvent extends Equatable {
  const RecipeViewPageEvent();

  @override
  List<Object> get props => [];
}

final class ChangeRecipesToDisplay extends RecipeViewPageEvent {
  const ChangeRecipesToDisplay();
}