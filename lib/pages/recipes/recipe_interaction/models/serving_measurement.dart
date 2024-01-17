part of 'recipe_interaction_models.dart';

class ServingMeasurement extends FormzInput<String, RecipeFormValidationError> {
  const ServingMeasurement.pure() : super.pure("");
  const ServingMeasurement.dirty([super.value = ""]) : super.dirty();

  static final RegExp _servingMeasurementExp = RegExp(
      r"^((?=.*[a-z])|(?=.*[A-Z]))[a-zA-Z'\s]+$"
  );

  @override
  RecipeFormValidationError? validator(String value) {
    return _servingMeasurementExp.hasMatch(value)
        ? null
        : RecipeFormValidationError.servingMeasurementInvalid;
  }
}