import 'package:formz/formz.dart';
import 'package:recipe_social_media/pages/recipes/recipe_interaction/models/recipe_form_validation_error.dart';

class IngredientQuantity extends FormzInput<String, RecipeFormValidationError> {
  const IngredientQuantity.pure() : super.pure("");
  const IngredientQuantity.dirty([super.value = ""]) : super.dirty();

  static final RegExp _ingredientQuantityExp = RegExp(
      ""
  );

  @override
  RecipeFormValidationError? validator(String value) {
    return null;
    //return _ingredientQuantityExp.hasMatch(value);
  }
}