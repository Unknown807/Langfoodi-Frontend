part of 'recipe_interaction_models.dart';

class RecipeStepDescription extends FormzInput<String, RecipeFormValidationError> {
  const RecipeStepDescription.pure() : super.pure("");
  const RecipeStepDescription.dirty([super.value = ""]) : super.dirty();

  @override
  RecipeFormValidationError? validator(String value) {
    return value.isNotEmpty
        ? null
        : RecipeFormValidationError.recipeStepDescriptionInvalid;
  }
}