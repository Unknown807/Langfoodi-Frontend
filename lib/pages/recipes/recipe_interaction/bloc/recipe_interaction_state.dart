import 'package:equatable/equatable.dart';
import 'package:recipe_social_media/pages/recipes/recipe_interaction/models/ingredient_measurement.dart';
import 'package:recipe_social_media/pages/recipes/recipe_interaction/models/ingredient_name.dart';
import 'package:recipe_social_media/pages/recipes/recipe_interaction/models/ingredient_quantity.dart';
import 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';

class RecipeInteractionState extends Equatable {
  const RecipeInteractionState({
    this.ingredientList = const [],
    this.ingredientName = const IngredientName.pure(),
    this.ingredientQuantity = const IngredientQuantity.pure(),
    this.ingredientMeasurement = const IngredientMeasurement.pure(),
    this.ingredientNameValid = false,
    this.ingredientQuantityValid = false,
    this.ingredientMeasurementValid = false
  });

  final List<Ingredient> ingredientList;
  final IngredientName ingredientName;
  final IngredientQuantity ingredientQuantity;
  final IngredientMeasurement ingredientMeasurement;
  final bool ingredientNameValid;
  final bool ingredientQuantityValid;
  final bool ingredientMeasurementValid;


  @override
  List<Object?> get props => [
    ingredientList, ingredientName, ingredientQuantity,
    ingredientMeasurement, ingredientNameValid,
    ingredientQuantityValid, ingredientMeasurementValid
  ];

  RecipeInteractionState copyWith({
    List<Ingredient>? ingredientList,
    IngredientName? ingredientName,
    IngredientQuantity? ingredientQuantity,
    IngredientMeasurement? ingredientMeasurement,
    bool? ingredientNameValid,
    bool? ingredientQuantityValid,
    bool? ingredientMeasurementValid
  }) {
    return RecipeInteractionState(
      ingredientList: ingredientList ?? this.ingredientList,
      ingredientName: ingredientName ?? this.ingredientName,
      ingredientQuantity: ingredientQuantity ?? this.ingredientQuantity,
      ingredientMeasurement: ingredientMeasurement ?? this.ingredientMeasurement,
      ingredientNameValid: ingredientNameValid ?? this.ingredientNameValid,
      ingredientQuantityValid: ingredientQuantityValid ?? this.ingredientQuantityValid,
      ingredientMeasurementValid: ingredientMeasurementValid ?? this.ingredientMeasurementValid
    );
  }
}