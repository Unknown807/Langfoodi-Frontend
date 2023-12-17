part of 'recipe_interaction_models.dart';

class ServingMeasurement extends FormzInput<String, RecipeFormValidationError> {
  const ServingMeasurement.pure() : super.pure("");
  const ServingMeasurement.dirty([super.value = ""]) : super.dirty();

  static final RegExp _servingMeasurementExp = RegExp(
      r"^(?!0(\.0+)?$)\d+(\.\d+)?$"
  );

  @override
  RecipeFormValidationError? validator(String value) {
    return _servingMeasurementExp.hasMatch(value)
        ? null
        : RecipeFormValidationError.servingMeasurementInvalid;
  }
}