import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:recipe_social_media/pages/recipes/recipe_interaction/bloc/recipe_interaction_event.dart';
import 'package:recipe_social_media/pages/recipes/recipe_interaction/bloc/recipe_interaction_state.dart';
import 'package:recipe_social_media/pages/recipes/recipe_interaction/models/ingredient_measurement.dart';
import 'package:recipe_social_media/pages/recipes/recipe_interaction/models/ingredient_name.dart';
import 'package:recipe_social_media/pages/recipes/recipe_interaction/models/ingredient_quantity.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';

class RecipeInteractionBloc extends Bloc<RecipeInteractionEvent, RecipeInteractionState> {
  RecipeInteractionBloc(this._authRepo, this._recipeRepo) : super(const RecipeInteractionState()) {
    on<AddNewIngredientFromName>(_addNewIngredientFromName);
    on<AddNewIngredientFromQuantity>(_addNewIngredientFromQuantity);
    on<AddNewIngredientFromMeasurement>(_addNewIngredientFromMeasurement);
    on<IngredientNameChanged>(_ingredientNameChanged);
    on<IngredientQuantityChanged>(_ingredientQuantityChanged);
    on<IngredientMeasurementChanged>(_ingredientMeasurementChanged);
  }

  final AuthenticationRepository _authRepo;
  final RecipeRepository _recipeRepo;

  void _ingredientNameChanged(IngredientNameChanged event, Emitter<RecipeInteractionState> emit) {
    final name = IngredientName.dirty(event.name);

    emit(state.copyWith(
      ingredientName: name,
      ingredientNameValid: Formz.validate([name])
    ));
  }

  void _ingredientQuantityChanged(IngredientQuantityChanged event, Emitter<RecipeInteractionState> emit) {
    final quantity = IngredientQuantity.dirty(event.quantity);

    emit(state.copyWith(
        ingredientQuantity: quantity,
        ingredientQuantityValid: Formz.validate([quantity])
    ));
  }

  void _ingredientMeasurementChanged(IngredientMeasurementChanged event, Emitter<RecipeInteractionState> emit) {
    final measurement = IngredientMeasurement.dirty(event.measurement);

    emit(state.copyWith(
        ingredientMeasurement: measurement,
        ingredientMeasurementValid: Formz.validate([measurement])
    ));
  }

  void _addNewIngredientFromName(AddNewIngredientFromName event, Emitter<RecipeInteractionState> emit) {
    _addNewIngredient(
        event.name,
        state.ingredientQuantity.value,
        state.ingredientMeasurement.value);
  }

  void _addNewIngredientFromQuantity(AddNewIngredientFromQuantity event, Emitter<RecipeInteractionState> emit) {
    _addNewIngredient(
        state.ingredientName.value,
        event.quantity,
        state.ingredientMeasurement.value);
  }

  void _addNewIngredientFromMeasurement(AddNewIngredientFromMeasurement event, Emitter<RecipeInteractionState> emit) {
    _addNewIngredient(
        state.ingredientName.value,
        state.ingredientQuantity.value,
        event.measurement);
  }

  void _addNewIngredient(String ingredientName, String ingredientQuantity, String ingredientMeasurement) {
    final name = IngredientName.dirty(ingredientName);
    final quantity = IngredientQuantity.dirty(ingredientQuantity);
    final measurement = IngredientMeasurement.dirty(ingredientMeasurement);
    final nameValid = Formz.validate([name]);
    final quantityValid = Formz.validate([quantity]);
    final measurementValid = Formz.validate([measurement]);

    if (nameValid && quantityValid && measurementValid) {
      List<Ingredient> ingredientsList = List.from(state.ingredientList);
      ingredientsList.add(Ingredient(name.value, double.tryParse(quantity.value)!, measurement.value));
      emit(state.copyWith(
        ingredientName: const IngredientName.pure(),
        ingredientQuantity: const IngredientQuantity.pure(),
        ingredientMeasurement: const IngredientMeasurement.pure(),
        ingredientNameValid: true,
        ingredientQuantityValid: true,
        ingredientMeasurementValid: true,
        ingredientList: ingredientsList
      ));
    } else {
      emit(state.copyWith(
          ingredientName: name,
          ingredientQuantity: quantity,
          ingredientMeasurement: measurement,
          ingredientNameValid: nameValid,
          ingredientQuantityValid: quantityValid,
          ingredientMeasurementValid: measurementValid));
    }
  }
}
