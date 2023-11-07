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
    required this.recipeStepDescriptionTextController,
    required this.recipeTagTextController,
    this.ingredientList = const [],
    this.recipeStepList = const [],
    this.recipeTagList = const [],
    this.ingredientName = const IngredientName.pure(),
    this.ingredientQuantity = const IngredientQuantity.pure(),
    this.ingredientMeasurement = const IngredientMeasurement.pure(),
    this.servingNumber = const ServingNumber.pure(),
    this.servingSize = const ServingSize.pure(),
    this.kilocalories = const Kilocalories.pure(),
    this.cookingTime = const CookingTime.pure(),
    this.recipeStepDescription = const RecipeStepDescription.pure(),
    this.recipeTag = const RecipeTag.pure(),
    this.ingredientNameValid = true,
    this.ingredientQuantityValid = true,
    this.ingredientMeasurementValid = true,
    this.servingNumberValid = true,
    this.servingSizeValid = true,
    this.kilocaloriesValid = true,
    this.cookingTimeValid = true,
    this.recipeStepDescriptionValid = true,
    this.recipeTagValid = true,
    this.recipeThumbnailPath = "",
    this.recipeStepImagePath = "",
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
  final TextEditingController recipeStepDescriptionTextController;
  final TextEditingController recipeTagTextController;
  final FormzSubmissionStatus formStatus;
  final List<Ingredient> ingredientList;
  final List<RecipeStep> recipeStepList;
  final List<String> recipeTagList;
  final IngredientName ingredientName;
  final IngredientQuantity ingredientQuantity;
  final IngredientMeasurement ingredientMeasurement;
  final ServingNumber servingNumber;
  final ServingSize servingSize;
  final Kilocalories kilocalories;
  final CookingTime cookingTime;
  final RecipeStepDescription recipeStepDescription;
  final RecipeTag recipeTag;
  final bool ingredientNameValid;
  final bool ingredientQuantityValid;
  final bool ingredientMeasurementValid;
  final bool servingNumberValid;
  final bool servingSizeValid;
  final bool kilocaloriesValid;
  final bool cookingTimeValid;
  final bool recipeStepDescriptionValid;
  final bool recipeTagValid;
  final String recipeThumbnailPath;
  final String recipeStepImagePath;

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
    kilocaloriesTextController, recipeStepImagePath, recipeStepList,
    recipeStepDescription, recipeStepDescriptionValid,
    recipeStepDescriptionTextController, recipeTagList,
    recipeTagValid, recipeTagTextController, recipeTag
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
    TextEditingController? recipeStepDescriptionTextController,
    TextEditingController? recipeTagTextController,
    FormzSubmissionStatus? formStatus,
    List<Ingredient>? ingredientList,
    List<RecipeStep>? recipeStepList,
    List<String>? recipeTagList,
    IngredientName? ingredientName,
    IngredientQuantity? ingredientQuantity,
    IngredientMeasurement? ingredientMeasurement,
    ServingNumber? servingNumber,
    ServingSize? servingSize,
    Kilocalories? kilocalories,
    CookingTime? cookingTime,
    RecipeStepDescription? recipeStepDescription,
    RecipeTag? recipeTag,
    bool? ingredientNameValid,
    bool? ingredientQuantityValid,
    bool? ingredientMeasurementValid,
    bool? servingNumberValid,
    bool? servingSizeValid,
    bool? kilocaloriesValid,
    bool? cookingTimeValid,
    bool? recipeStepDescriptionValid,
    bool? recipeTagValid,
    String? recipeThumbnailPath,
    String? recipeStepImagePath
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
      recipeStepDescriptionTextController: recipeStepDescriptionTextController ?? this.recipeStepDescriptionTextController,
      recipeTagTextController: recipeTagTextController ?? this.recipeTagTextController,
      ingredientList: ingredientList ?? this.ingredientList,
      recipeStepList: recipeStepList ?? this.recipeStepList,
      recipeTagList: recipeTagList ?? this.recipeTagList,
      ingredientName: ingredientName ?? this.ingredientName,
      ingredientQuantity: ingredientQuantity ?? this.ingredientQuantity,
      ingredientMeasurement: ingredientMeasurement ?? this.ingredientMeasurement,
      servingNumber: servingNumber ?? this.servingNumber,
      servingSize: servingSize ?? this.servingSize,
      kilocalories: kilocalories ?? this.kilocalories,
      cookingTime: cookingTime ?? this.cookingTime,
      recipeStepDescription: recipeStepDescription ?? this.recipeStepDescription,
      recipeTag: recipeTag ?? this.recipeTag,
      ingredientNameValid: ingredientNameValid ?? this.ingredientNameValid,
      ingredientQuantityValid: ingredientQuantityValid ?? this.ingredientQuantityValid,
      ingredientMeasurementValid: ingredientMeasurementValid ?? this.ingredientMeasurementValid,
      servingNumberValid: servingNumberValid ?? this.servingNumberValid,
      servingSizeValid: servingSizeValid ?? this.servingSizeValid,
      kilocaloriesValid: kilocaloriesValid ?? this.kilocaloriesValid,
      cookingTimeValid: cookingTimeValid ?? this.cookingTimeValid,
      recipeStepDescriptionValid: recipeStepDescriptionValid ?? this.recipeStepDescriptionValid,
      recipeTagValid: recipeTagValid ?? this.recipeTagValid,
      recipeThumbnailPath: recipeThumbnailPath ?? this.recipeThumbnailPath,
      recipeStepImagePath: recipeStepImagePath ?? this.recipeStepImagePath,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}