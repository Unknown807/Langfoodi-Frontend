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