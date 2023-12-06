part of 'recipe_interaction_models.dart';

class CookingTime extends FormzInput<String, RecipeFormValidationError> {
  const CookingTime.pure() : super.pure("");
  const CookingTime.dirty([super.value = ""]) : super.dirty();

  static final RegExp _cookingTimeExp = RegExp(
    r"^[0-9][0-9]:[0-9][0-9]:[0-9][0-9]$"
  );

  Duration getCookingTimeAsDuration() {
    final cookingTimeParts = value.split(":");
    return Duration(
        hours: int.parse(cookingTimeParts[0]),
        minutes: int.parse(cookingTimeParts[1]),
        seconds: int.parse(cookingTimeParts[2])
    );
  }

  @override
  RecipeFormValidationError? validator(String value) {
    return _cookingTimeExp.hasMatch(value)
        ? null
        : RecipeFormValidationError.cookingTimeInvalid;
  }
}