part of 'recipe_interaction_models.dart';

class ServingSize extends FormzInput<String, RecipeFormValidationError> {
  const ServingSize.pure() : super.pure("");
  const ServingSize.dirty([super.value = ""]) : super.dirty();

  static final RegExp _servingSizeExp = RegExp(
      r"^(?!0(\.0+)?$)\d+(\.\d+)?$"
  );

  @override
  RecipeFormValidationError? validator(String value) {
    return _servingSizeExp.hasMatch(value)
        ? null
        : RecipeFormValidationError.servingSizeInvalid;
  }
}