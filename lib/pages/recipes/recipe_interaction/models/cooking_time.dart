part of 'recipe_interaction_models.dart';

class CookingTime extends FormzInput<String, RecipeFormValidationError> {
  const CookingTime.pure() : super.pure("");
  const CookingTime.dirty([super.value = ""]) : super.dirty();

  static final RegExp _cookingTimeExp = RegExp(
    r"^[0-9][0-9]:[0-9][0-9]:[0-9][0-9]$"
  );

  @override
  RecipeFormValidationError? validator(String value) {
    return _cookingTimeExp.hasMatch(value) && (value != "00:00:00")
        ? null
        : RecipeFormValidationError.cookingTimeInvalid;
  }
}