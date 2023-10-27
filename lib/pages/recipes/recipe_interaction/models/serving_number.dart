part of 'recipe_interaction_models.dart';

class ServingNumber extends FormzInput<String, RecipeFormValidationError> {
  const ServingNumber.pure() : super.pure("");
  const ServingNumber.dirty([super.value = ""]) : super.dirty();

  static final RegExp _servingNumberExp = RegExp(
    r"^[1-9][0-9]{0,2}$"
  );

  @override
  RecipeFormValidationError? validator(String value) {
    return _servingNumberExp.hasMatch(value)
        ? null
        : RecipeFormValidationError.servingNumberInvalid;
  }
}