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

final class RemoveRecipeStep extends RecipeInteractionEvent {
  const RemoveRecipeStep(this.index);

  final int index;

  @override
  List<Object> get props => [index];
}

final class RecipeThumbnailPicked extends RecipeInteractionEvent {
  const RecipeThumbnailPicked(this.imagePath);

  final String imagePath;

  @override
  List<Object> get props => [imagePath];
}

final class RecipeStepImagePicked extends RecipeInteractionEvent {
  const RecipeStepImagePicked(this.imagePath);

  final String imagePath;

  @override
  List<Object> get props => [imagePath];
}

final class ServingNumberChanged extends RecipeInteractionEvent {
  const ServingNumberChanged(this.servingNumber);

  final String servingNumber;

  @override
  List<Object> get props => [servingNumber];
}

final class ServingSizeChanged extends RecipeInteractionEvent {
  const ServingSizeChanged(this.servingSize);

  final String servingSize;

  @override
  List<Object> get props => [servingSize];
}

final class KilocaloriesChanged extends RecipeInteractionEvent {
  const KilocaloriesChanged(this.kilocalories);

  final String kilocalories;

  @override
  List<Object> get props => [kilocalories];
}

final class CookingTimeChanged extends RecipeInteractionEvent {
  const CookingTimeChanged(this.cookingTime);

  final String cookingTime;

  @override
  List<Object> get props => [cookingTime];
}

final class RecipeStepDescriptionChanged extends RecipeInteractionEvent {
  const RecipeStepDescriptionChanged(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}

final class AddNewRecipeStepFromDescription extends RecipeInteractionEvent {
  const AddNewRecipeStepFromDescription(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}

final class ReorderRecipeStepList extends RecipeInteractionEvent {
  const ReorderRecipeStepList(this.oldIndex, this.newIndex);

  final int oldIndex;
  final int newIndex;

  @override
  List<Object> get props => [oldIndex, newIndex];
}