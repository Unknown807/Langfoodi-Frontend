import 'package:formz/formz.dart';
import 'package:recipe_social_media/pages/recipes/recipe_interaction/models/recipe_form_validation_error.dart';

class IngredientName extends FormzInput<String, RecipeFormValidationError> {
  const IngredientName.pure() : super.pure("");
  const IngredientName.dirty([super.value = ""]) : super.dirty();

  static final RegExp _ingredientNameExp = RegExp(
    ""
  );

  @override
  RecipeFormValidationError? validator(String value) {
    return null;
    //return _ingredientNameExp.hasMatch(value);
  }
}