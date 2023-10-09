part of 'recipe_interaction_models.dart';

class IngredientName extends FormzInput<String, RecipeFormValidationError> {
  const IngredientName.pure() : super.pure("");
  const IngredientName.dirty([super.value = ""]) : super.dirty();

  static final RegExp _ingredientNameExp = RegExp(
    r"^((?=.*[a-z])|(?=.*[A-Z]))[a-zA-Z'\s]+$"
  );

  @override
  RecipeFormValidationError? validator(String value) {
    return _ingredientNameExp.hasMatch(value)
        ? null
        : RecipeFormValidationError.ingredientNameInvalid;
  }
}