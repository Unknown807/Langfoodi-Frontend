part of 'recipe_interaction_models.dart';

class IngredientQuantity extends FormzInput<String, RecipeFormValidationError> {
  const IngredientQuantity.pure() : super.pure("");
  const IngredientQuantity.dirty([super.value = ""]) : super.dirty();

  static final RegExp _ingredientQuantityExp = RegExp(
      r"^(?!0(\.0+)?$)\d+(\.\d+)?$"
  );

  @override
  RecipeFormValidationError? validator(String value) {
    return _ingredientQuantityExp.hasMatch(value)
        ? null
        : RecipeFormValidationError.ingredientQuantityInvalid;
  }
}