part of 'recipe_interaction_models.dart';

class IngredientMeasurement extends FormzInput<String, RecipeFormValidationError> {
  const IngredientMeasurement.pure() : super.pure("");
  const IngredientMeasurement.dirty([super.value = ""]) : super.dirty();

  static final RegExp _ingredientMeasurementExp = RegExp(
      r"^((?=.*[a-z])|(?=.*[A-Z]))[a-zA-Z'\s]+$"
  );

  @override
  RecipeFormValidationError? validator(String value) {
    return _ingredientMeasurementExp.hasMatch(value)
        ? null
        : RecipeFormValidationError.ingredientMeasurementInvalid;
  }
}