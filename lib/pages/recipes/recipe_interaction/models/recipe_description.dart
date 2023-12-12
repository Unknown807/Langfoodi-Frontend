part of 'recipe_interaction_models.dart';

class RecipeDescription extends FormzInput<String, RecipeFormValidationError> {
  const RecipeDescription.pure() : super.pure("");
  const RecipeDescription.dirty([super.value = ""]) : super.dirty();

  @override
  RecipeFormValidationError? validator(String value) {
    return value.isNotEmpty
        ? null
        : RecipeFormValidationError.recipeDescriptionInvalid;
  }
}