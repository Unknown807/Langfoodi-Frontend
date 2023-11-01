part of 'recipe_interaction_models.dart';

class RecipeLabel extends FormzInput<String, RecipeFormValidationError> {
  const RecipeLabel.pure() : super.pure("");
  const RecipeLabel.dirty([super.value = ""]) : super.dirty();

  static final RegExp _recipeLabelExp = RegExp(
    r"^[a-zA-Z0-9]{1,20}$"
  );

  @override
  RecipeFormValidationError? validator(String value) {
    return _recipeLabelExp.hasMatch(value)
        ? null
        : RecipeFormValidationError.recipeLabelInvalid;
  }
}