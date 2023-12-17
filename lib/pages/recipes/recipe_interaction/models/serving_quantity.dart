part of 'recipe_interaction_models.dart';

class ServingQuantity extends FormzInput<String, RecipeFormValidationError> {
  const ServingQuantity.pure() : super.pure("");
  const ServingQuantity.dirty([super.value = ""]) : super.dirty();

  static final RegExp _servingQuantityExp = RegExp(
      r"^(?!0(\.0+)?$)\d+(\.\d+)?$"
  );

  @override
  RecipeFormValidationError? validator(String value) {
    return _servingQuantityExp.hasMatch(value)
        ? null
        : RecipeFormValidationError.servingQuantityInvalid;
  }
}