part of 'recipe_interaction_bloc.dart';

@immutable
sealed class RecipeInteractionEvent extends Equatable {
  const RecipeInteractionEvent();

  @override
  List<Object> get props => [];
}

final class IngredientNameChanged extends RecipeInteractionEvent {
  const IngredientNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

final class IngredientQuantityChanged extends RecipeInteractionEvent {
  const IngredientQuantityChanged(this.quantity);

  final String quantity;

  @override
  List<Object> get props => [quantity];
}

final class IngredientMeasurementChanged extends RecipeInteractionEvent {
  const IngredientMeasurementChanged(this.measurement);

  final String measurement;

  @override
  List<Object> get props => [measurement];
}

final class AddNewIngredientFromName extends RecipeInteractionEvent {
  const AddNewIngredientFromName(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

final class AddNewIngredientFromQuantity extends RecipeInteractionEvent {
  const AddNewIngredientFromQuantity(this.quantity);

  final String quantity;

  @override
  List<Object> get props => [quantity];
}

final class AddNewIngredientFromMeasurement extends RecipeInteractionEvent {
  const AddNewIngredientFromMeasurement(this.measurement);

  final String measurement;

  @override
  List<Object> get props => [measurement];
}

final class RemoveIngredient extends RecipeInteractionEvent {
  const RemoveIngredient(this.index);

  final int index;

  @override
  List<Object> get props => [index];
}

final class MainRecipeImagePicked extends RecipeInteractionEvent {
  const MainRecipeImagePicked(this.imagePath);

  final String imagePath;

  @override
  List<Object> get props => [imagePath];
}