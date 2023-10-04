import 'package:formz/formz.dart';
import 'package:recipe_social_media/pages/recipes/recipe_interaction/models/recipe_form_validation_error.dart';

class IngredientMeasurement extends FormzInput<String, RecipeFormValidationError> {
  const IngredientMeasurement.pure() : super.pure("");
  const IngredientMeasurement.dirty([super.value = ""]) : super.dirty();

  static final RegExp _ingredientMeasurementExp = RegExp(
      ""
  );

  @override
  RecipeFormValidationError? validator(String value) {
    return null;
    //return _ingredientMeasurementExp.hasMatch(value);
  }
}