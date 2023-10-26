part of 'recipe_interaction_models.dart';

class Kilocalories extends FormzInput<String, RecipeFormValidationError> {
  const Kilocalories.pure() : super.pure("");
  const Kilocalories.dirty([super.value = ""]) : super.dirty();

  static final RegExp _kilocaloriesExp = RegExp(
    r"^[0-9][0-9]{0,3}$"
  );

  @override
  RecipeFormValidationError? validator(String value) {
    return _kilocaloriesExp.hasMatch(value)
        ? null
        : RecipeFormValidationError.kilocaloriesInvalid;
  }
}