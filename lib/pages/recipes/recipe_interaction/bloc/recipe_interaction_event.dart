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

final class ServingQuantityChanged extends RecipeInteractionEvent {
  const ServingQuantityChanged(this.quantity);

  final String quantity;

  @override
  List<Object> get props => [quantity];
}

final class ServingMeasurementChanged extends RecipeInteractionEvent {
  const ServingMeasurementChanged(this.measurement);

  final String measurement;

  @override
  List<Object> get props => [measurement];
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

final class RecipeDescriptionChanged extends RecipeInteractionEvent {
  const RecipeDescriptionChanged(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}

final class RecipeTagChanged extends RecipeInteractionEvent {
  const RecipeTagChanged(this.tag);

  final String tag;

  @override
  List<Object> get props => [tag];
}

final class AddNewRecipeStepFromDescription extends RecipeInteractionEvent {
  const AddNewRecipeStepFromDescription(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}

final class AddNewRecipeTagFromField extends RecipeInteractionEvent {
  const AddNewRecipeTagFromField(this.tag);

  final String tag;

  @override
  List<Object> get props => [tag];
}

final class AddNewRecipeTagFromButton extends RecipeInteractionEvent {
  const AddNewRecipeTagFromButton();
}

final class RemoveRecipeTag extends RecipeInteractionEvent {
  const RemoveRecipeTag(this.index);

  final int index;

  @override
  List<Object> get props => [index];
}

final class ReorderRecipeStepList extends RecipeInteractionEvent {
  const ReorderRecipeStepList(this.oldIndex, this.newIndex);

  final int oldIndex;
  final int newIndex;

  @override
  List<Object> get props => [oldIndex, newIndex];
}

final class RecipeTitleChanged extends RecipeInteractionEvent {
  const RecipeTitleChanged(this.title);

  final String title;

  @override
  List<Object> get props => [title];
}

final class RecipeFormSubmission extends RecipeInteractionEvent {
  const RecipeFormSubmission();
}