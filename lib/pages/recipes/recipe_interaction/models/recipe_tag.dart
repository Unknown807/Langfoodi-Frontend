part of 'recipe_interaction_models.dart';

class RecipeTag extends FormzInput<String, RecipeFormValidationError> {
  const RecipeTag.pure() : super.pure("");
  const RecipeTag.dirty([super.value = ""]) : super.dirty();

  static final RegExp _recipeLabelExp = RegExp(
    r"^[a-zA-Z0-9]{1,20}$"
  );

  @override
  RecipeFormValidationError? validator(String value) {
    return _recipeLabelExp.hasMatch(value)
        ? null
        : RecipeFormValidationError.recipeTagInvalid;
  }
}