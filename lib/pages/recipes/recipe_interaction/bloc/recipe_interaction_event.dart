import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
sealed class RecipeInteractionEvent extends Equatable {
  const RecipeInteractionEvent();

  @override
  List<Object> get props => [];
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