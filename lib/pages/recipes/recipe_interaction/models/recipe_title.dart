part of 'recipe_interaction_models.dart';

class RecipeTitle extends FormzInput<String, RecipeFormValidationError> {
  const RecipeTitle.pure() : super.pure("");
  const RecipeTitle.dirty([super.value = ""]) : super.dirty();

  static final RegExp _recipeTitleExp = RegExp(
    r"^((?=.*[a-z])|(?=.*[A-Z]))[a-zA-Z'\s]+$"
  );

  @override
  RecipeFormValidationError? validator(String value) {
    return _recipeTitleExp.hasMatch(value)
        ? null
        : RecipeFormValidationError.recipeTitleInvalid;
  }
}