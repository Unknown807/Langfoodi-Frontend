part of 'recipe_interaction_bloc.dart';

class RecipeInteractionState extends Equatable {
  const RecipeInteractionState({
    required this.ingredientNameTextController,
    required this.ingredientQuantityTextController,
    required this.ingredientMeasurementTextController,
    required this.servingNumberTextController,
    required this.servingQuantityTextController,
    required this.servingMeasurementTextController,
    required this.kilocaloriesTextController,
    required this.cookingTimeTextController,
    required this.cookingTimeHiddenTextController,
    required this.recipeStepDescriptionTextController,
    required this.recipeDescriptionTextController,
    required this.recipeTitleTextController,
    required this.recipeTagTextController,
    this.ingredientList = const [],
    this.recipeStepList = const [],
    this.currentRecipeStepImageIds = const [],
    this.recipeTagList = const [],
    this.ingredientName = const IngredientName.pure(),
    this.ingredientQuantity = const IngredientQuantity.pure(),
    this.ingredientMeasurement = const IngredientMeasurement.pure(),
    this.servingNumber = const ServingNumber.pure(),
    this.servingQuantity = const ServingQuantity.pure(),
    this.servingMeasurement = const ServingMeasurement.pure(),
    this.kilocalories = const Kilocalories.pure(),
    this.cookingTime = const CookingTime.pure(),
    this.recipeStepDescription = const RecipeStepDescription.pure(),
    this.recipeDescription = const RecipeDescription.pure(),
    this.recipeTitle = const RecipeTitle.pure(),
    this.recipeTag = const RecipeTag.pure(),
    this.ingredientNameValid = true,
    this.ingredientQuantityValid = true,
    this.ingredientMeasurementValid = true,
    this.servingNumberValid = true,
    this.servingQuantityValid = true,
    this.servingMeasurementValid = true,
    this.kilocaloriesValid = true,
    this.cookingTimeValid = true,
    this.recipeStepDescriptionValid = true,
    this.recipeDescriptionValid = true,
    this.recipeTitleValid = true,
    this.recipeTagValid = true,
    this.recipeThumbnailPath = "",
    this.currentRecipeThumbnailId = "",
    this.recipeStepImagePath = "",
    this.formStatus = FormzSubmissionStatus.initial,
    this.pageType = RecipeInteractionType.create,
    this.currentRecipeId = ""
  });

  final String currentRecipeId;
  final RecipeInteractionType pageType;
  final TextEditingController ingredientNameTextController;
  final TextEditingController ingredientQuantityTextController;
  final TextEditingController ingredientMeasurementTextController;
  final TextEditingController servingNumberTextController;
  final TextEditingController servingQuantityTextController;
  final TextEditingController servingMeasurementTextController;
  final TextEditingController kilocaloriesTextController;
  final TextEditingController cookingTimeTextController;
  final TextEditingController cookingTimeHiddenTextController;
  final TextEditingController recipeStepDescriptionTextController;
  final TextEditingController recipeDescriptionTextController;
  final TextEditingController recipeTitleTextController;
  final TextEditingController recipeTagTextController;
  final FormzSubmissionStatus formStatus;
  final List<Ingredient> ingredientList;
  final List<RecipeStep> recipeStepList;
  final List<String> currentRecipeStepImageIds;
  final List<String> recipeTagList;
  final IngredientName ingredientName;
  final IngredientQuantity ingredientQuantity;
  final IngredientMeasurement ingredientMeasurement;
  final ServingNumber servingNumber;
  final ServingQuantity servingQuantity;
  final ServingMeasurement servingMeasurement;
  final Kilocalories kilocalories;
  final CookingTime cookingTime;
  final RecipeStepDescription recipeStepDescription;
  final RecipeDescription recipeDescription;
  final RecipeTitle recipeTitle;
  final RecipeTag recipeTag;
  final bool ingredientNameValid;
  final bool ingredientQuantityValid;
  final bool ingredientMeasurementValid;
  final bool servingNumberValid;
  final bool servingQuantityValid;
  final bool servingMeasurementValid;
  final bool kilocaloriesValid;
  final bool cookingTimeValid;
  final bool recipeStepDescriptionValid;
  final bool recipeDescriptionValid;
  final bool recipeTitleValid;
  final bool recipeTagValid;
  final String recipeThumbnailPath;
  final String currentRecipeThumbnailId;
  final String recipeStepImagePath;

  @override
  List<Object?> get props => [
    ingredientList, ingredientName, ingredientQuantity,
    ingredientMeasurement, ingredientNameValid,
    ingredientQuantityValid, ingredientMeasurementValid,
    formStatus, recipeThumbnailPath, servingNumber,
    servingNumberValid, servingQuantity,
    servingMeasurement, servingQuantityValid, servingMeasurementValid,
    kilocalories, kilocaloriesValid, cookingTime,
    cookingTimeValid, ingredientMeasurementTextController,
    ingredientNameTextController, ingredientQuantityTextController,
    cookingTimeTextController, cookingTimeHiddenTextController,
    servingNumberTextController, servingQuantityTextController,
    servingMeasurementTextController,
    kilocaloriesTextController, recipeStepImagePath, recipeStepList,
    recipeStepDescription, recipeStepDescriptionValid,
    recipeStepDescriptionTextController, recipeDescription,
    recipeDescriptionValid, recipeTitle, recipeTitleValid,
    recipeDescriptionTextController, recipeTitleTextController,
    recipeTagList, recipeTagValid, recipeTagTextController, recipeTag,
    pageType, currentRecipeId, currentRecipeStepImageIds,
    currentRecipeThumbnailId
  ];

  RecipeInteractionState copyWith({
    TextEditingController? ingredientNameTextController,
    TextEditingController? ingredientQuantityTextController,
    TextEditingController? ingredientMeasurementTextController,
    TextEditingController? servingNumberTextController,
    TextEditingController? servingQuantityTextController,
    TextEditingController? servingMeasurementTextController,
    TextEditingController? kilocaloriesTextController,
    TextEditingController? cookingTimeTextController,
    TextEditingController? cookingTimeHiddenTextController,
    TextEditingController? recipeStepDescriptionTextController,
    TextEditingController? recipeDescriptionTextController,
    TextEditingController? recipeTitleTextController,
    TextEditingController? recipeTagTextController,
    FormzSubmissionStatus? formStatus,
    List<Ingredient>? ingredientList,
    List<RecipeStep>? recipeStepList,
    List<String>? recipeTagList,
    List<String>? currentRecipeStepImageIds,
    IngredientName? ingredientName,
    IngredientQuantity? ingredientQuantity,
    IngredientMeasurement? ingredientMeasurement,
    ServingNumber? servingNumber,
    ServingQuantity? servingQuantity,
    ServingMeasurement? servingMeasurement,
    Kilocalories? kilocalories,
    CookingTime? cookingTime,
    RecipeStepDescription? recipeStepDescription,
    RecipeDescription? recipeDescription,
    RecipeTitle? recipeTitle,
    RecipeTag? recipeTag,
    bool? ingredientNameValid,
    bool? ingredientQuantityValid,
    bool? ingredientMeasurementValid,
    bool? servingNumberValid,
    bool? servingQuantityValid,
    bool? servingMeasurementValid,
    bool? kilocaloriesValid,
    bool? cookingTimeValid,
    bool? recipeStepDescriptionValid,
    bool? recipeDescriptionValid,
    bool? recipeTitleValid,
    bool? recipeTagValid,
    String? recipeThumbnailPath,
    String? currentRecipeThumbnailId,
    String? recipeStepImagePath,
    RecipeInteractionType? pageType,
    String? currentRecipeId
  }) {
    return RecipeInteractionState(
      ingredientNameTextController: ingredientNameTextController ?? this.ingredientNameTextController,
      ingredientQuantityTextController: ingredientQuantityTextController ?? this.ingredientQuantityTextController,
      ingredientMeasurementTextController: ingredientMeasurementTextController ?? this.ingredientMeasurementTextController,
      servingNumberTextController: servingNumberTextController ?? this.servingNumberTextController,
      servingQuantityTextController: servingQuantityTextController ?? this.servingQuantityTextController,
      servingMeasurementTextController: servingMeasurementTextController ?? this.servingMeasurementTextController,
      kilocaloriesTextController: kilocaloriesTextController ?? this.kilocaloriesTextController,
      cookingTimeTextController: cookingTimeTextController ?? this.cookingTimeTextController,
      cookingTimeHiddenTextController: cookingTimeHiddenTextController ?? this.cookingTimeHiddenTextController,
      recipeStepDescriptionTextController: recipeStepDescriptionTextController ?? this.recipeStepDescriptionTextController,
      recipeDescriptionTextController: recipeDescriptionTextController ?? this.recipeDescriptionTextController,
      recipeTitleTextController: recipeTitleTextController ?? this.recipeTitleTextController,
      recipeTagTextController: recipeTagTextController ?? this.recipeTagTextController,
      ingredientList: ingredientList ?? this.ingredientList,
      recipeStepList: recipeStepList ?? this.recipeStepList,
      currentRecipeStepImageIds: currentRecipeStepImageIds ?? this.currentRecipeStepImageIds,
      recipeTagList: recipeTagList ?? this.recipeTagList,
      ingredientName: ingredientName ?? this.ingredientName,
      ingredientQuantity: ingredientQuantity ?? this.ingredientQuantity,
      ingredientMeasurement: ingredientMeasurement ?? this.ingredientMeasurement,
      servingNumber: servingNumber ?? this.servingNumber,
      servingQuantity: servingQuantity ?? this.servingQuantity,
      servingMeasurement: servingMeasurement ?? this.servingMeasurement,
      kilocalories: kilocalories ?? this.kilocalories,
      cookingTime: cookingTime ?? this.cookingTime,
      recipeStepDescription: recipeStepDescription ?? this.recipeStepDescription,
      recipeTitle: recipeTitle ?? this.recipeTitle,
      recipeDescription: recipeDescription ?? this.recipeDescription,
      recipeTag: recipeTag ?? this.recipeTag,
      ingredientNameValid: ingredientNameValid ?? this.ingredientNameValid,
      ingredientQuantityValid: ingredientQuantityValid ?? this.ingredientQuantityValid,
      ingredientMeasurementValid: ingredientMeasurementValid ?? this.ingredientMeasurementValid,
      servingNumberValid: servingNumberValid ?? this.servingNumberValid,
      servingQuantityValid: servingQuantityValid ?? this.servingQuantityValid,
      servingMeasurementValid: servingMeasurementValid ?? this.servingMeasurementValid,
      kilocaloriesValid: kilocaloriesValid ?? this.kilocaloriesValid,
      cookingTimeValid: cookingTimeValid ?? this.cookingTimeValid,
      recipeStepDescriptionValid: recipeStepDescriptionValid ?? this.recipeStepDescriptionValid,
      recipeDescriptionValid: recipeDescriptionValid ?? this.recipeDescriptionValid,
      recipeTitleValid: recipeTitleValid ?? this.recipeTitleValid,
      recipeTagValid: recipeTagValid ?? this.recipeTagValid,
      recipeThumbnailPath: recipeThumbnailPath ?? this.recipeThumbnailPath,
      currentRecipeThumbnailId: currentRecipeThumbnailId ?? this.currentRecipeThumbnailId,
      recipeStepImagePath: recipeStepImagePath ?? this.recipeStepImagePath,
      formStatus: formStatus ?? this.formStatus,
      currentRecipeId: currentRecipeId ?? this.currentRecipeId,
      pageType: pageType ?? this.pageType,
    );
  }
}