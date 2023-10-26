part of 'recipe_interaction_bloc.dart';

class RecipeInteractionState extends Equatable {
  const RecipeInteractionState({
    required this.ingredientNameTextController,
    required this.ingredientQuantityTextController,
    required this.ingredientMeasurementTextController,
    required this.servingNumberTextController,
    required this.servingSizeTextController,
    required this.kilocaloriesTextController,
    required this.cookingTimeTextController,
    required this.cookingTimeHiddenTextController,
    this.ingredientList = const [],
    this.ingredientName = const IngredientName.pure(),
    this.ingredientQuantity = const IngredientQuantity.pure(),
    this.ingredientMeasurement = const IngredientMeasurement.pure(),
    this.servingNumber = const ServingNumber.pure(),
    this.servingSize = const ServingSize.pure(),
    this.kilocalories = const Kilocalories.pure(),
    this.cookingTime = const CookingTime.pure(),
    this.ingredientNameValid = false,
    this.ingredientQuantityValid = false,
    this.ingredientMeasurementValid = false,
    this.servingNumberValid = false,
    this.servingSizeValid = false,
    this.kilocaloriesValid = false,
    this.cookingTimeValid = false,
    this.recipeThumbnailPath = "",
    this.formStatus = FormzSubmissionStatus.initial
  });

  final TextEditingController ingredientNameTextController;
  final TextEditingController ingredientQuantityTextController;
  final TextEditingController ingredientMeasurementTextController;
  final TextEditingController servingNumberTextController;
  final TextEditingController servingSizeTextController;
  final TextEditingController kilocaloriesTextController;
  final TextEditingController cookingTimeTextController;
  final TextEditingController cookingTimeHiddenTextController;
  final FormzSubmissionStatus formStatus;
  final List<Ingredient> ingredientList;
  final IngredientName ingredientName;
  final IngredientQuantity ingredientQuantity;
  final IngredientMeasurement ingredientMeasurement;
  final ServingNumber servingNumber;
  final ServingSize servingSize;
  final Kilocalories kilocalories;
  final CookingTime cookingTime;
  final bool ingredientNameValid;
  final bool ingredientQuantityValid;
  final bool ingredientMeasurementValid;
  final bool servingNumberValid;
  final bool servingSizeValid;
  final bool kilocaloriesValid;
  final bool cookingTimeValid;
  final String recipeThumbnailPath;

  @override
  List<Object?> get props => [
    ingredientList, ingredientName, ingredientQuantity,
    ingredientMeasurement, ingredientNameValid,
    ingredientQuantityValid, ingredientMeasurementValid,
    formStatus, recipeThumbnailPath, servingNumber,
    servingNumberValid, servingSize, servingSizeValid,
    kilocalories, kilocaloriesValid, cookingTime,
    cookingTimeValid, ingredientMeasurementTextController,
    ingredientNameTextController, ingredientQuantityTextController,
    cookingTimeTextController, cookingTimeHiddenTextController,
    servingNumberTextController, servingSizeTextController,
    kilocaloriesTextController
  ];

  RecipeInteractionState copyWith({
    TextEditingController? ingredientNameTextController,
    TextEditingController? ingredientQuantityTextController,
    TextEditingController? ingredientMeasurementTextController,
    TextEditingController? servingNumberTextController,
    TextEditingController? servingSizeTextController,
    TextEditingController? kilocaloriesTextController,
    TextEditingController? cookingTimeTextController,
    TextEditingController? cookingTimeHiddenTextController,
    FormzSubmissionStatus? formStatus,
    List<Ingredient>? ingredientList,
    IngredientName? ingredientName,
    IngredientQuantity? ingredientQuantity,
    IngredientMeasurement? ingredientMeasurement,
    ServingNumber? servingNumber,
    ServingSize? servingSize,
    Kilocalories? kilocalories,
    CookingTime? cookingTime,
    bool? ingredientNameValid,
    bool? ingredientQuantityValid,
    bool? ingredientMeasurementValid,
    bool? servingNumberValid,
    bool? servingSizeValid,
    bool? kilocaloriesValid,
    bool? cookingTimeValid,
    String? recipeThumbnailPath
  }) {
    return RecipeInteractionState(
      ingredientNameTextController: ingredientNameTextController ?? this.ingredientNameTextController,
      ingredientQuantityTextController: ingredientQuantityTextController ?? this.ingredientQuantityTextController,
      ingredientMeasurementTextController: ingredientMeasurementTextController ?? this.ingredientMeasurementTextController,
      servingNumberTextController: servingNumberTextController ?? this.servingNumberTextController,
      servingSizeTextController: servingSizeTextController ?? this.servingSizeTextController,
      kilocaloriesTextController: kilocaloriesTextController ?? this.kilocaloriesTextController,
      cookingTimeTextController: cookingTimeTextController ?? this.cookingTimeTextController,
      cookingTimeHiddenTextController: cookingTimeHiddenTextController ?? this.cookingTimeHiddenTextController,
      formStatus: formStatus ?? this.formStatus,
      ingredientList: ingredientList ?? this.ingredientList,
      ingredientName: ingredientName ?? this.ingredientName,
      ingredientQuantity: ingredientQuantity ?? this.ingredientQuantity,
      ingredientMeasurement: ingredientMeasurement ?? this.ingredientMeasurement,
      servingNumber: servingNumber ?? this.servingNumber,
      servingSize: servingSize ?? this.servingSize,
      kilocalories: kilocalories ?? this.kilocalories,
      cookingTime: cookingTime ?? this.cookingTime,
      ingredientNameValid: ingredientNameValid ?? this.ingredientNameValid,
      ingredientQuantityValid: ingredientQuantityValid ?? this.ingredientQuantityValid,
      ingredientMeasurementValid: ingredientMeasurementValid ?? this.ingredientMeasurementValid,
      servingNumberValid: servingNumberValid ?? this.servingNumberValid,
      servingSizeValid: servingSizeValid ?? this.servingSizeValid,
      kilocaloriesValid: kilocaloriesValid ?? this.kilocaloriesValid,
      cookingTimeValid: cookingTimeValid ?? this.cookingTimeValid,
      recipeThumbnailPath: recipeThumbnailPath ?? this.recipeThumbnailPath
    );
  }
}