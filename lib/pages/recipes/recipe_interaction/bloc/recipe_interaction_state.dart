part of 'recipe_interaction_bloc.dart';

class RecipeInteractionState extends Equatable {
  const RecipeInteractionState({
    required this.ingredientNameTextController,
    required this.ingredientQuantityTextController,
    required this.ingredientMeasurementTextController,
    this.ingredientList = const [],
    this.ingredientName = const IngredientName.pure(),
    this.ingredientQuantity = const IngredientQuantity.pure(),
    this.ingredientMeasurement = const IngredientMeasurement.pure(),
    this.servingNumber = const ServingNumber.pure(),
    this.servingSize = const ServingSize.pure(),
    this.ingredientNameValid = false,
    this.ingredientQuantityValid = false,
    this.ingredientMeasurementValid = false,
    this.servingNumberValid = false,
    this.servingSizeValid = false,
    this.recipeThumbnailPath = "",
    this.formStatus = FormzSubmissionStatus.initial
  });

  final TextEditingController ingredientNameTextController;
  final TextEditingController ingredientQuantityTextController;
  final TextEditingController ingredientMeasurementTextController;
  final FormzSubmissionStatus formStatus;
  final List<Ingredient> ingredientList;
  final IngredientName ingredientName;
  final IngredientQuantity ingredientQuantity;
  final IngredientMeasurement ingredientMeasurement;
  final ServingNumber servingNumber;
  final ServingSize servingSize;
  final bool ingredientNameValid;
  final bool ingredientQuantityValid;
  final bool ingredientMeasurementValid;
  final bool servingNumberValid;
  final bool servingSizeValid;
  final String recipeThumbnailPath;

  @override
  List<Object?> get props => [
    ingredientList, ingredientName, ingredientQuantity,
    ingredientMeasurement, ingredientNameValid,
    ingredientQuantityValid, ingredientMeasurementValid,
    formStatus, recipeThumbnailPath, servingNumber,
    servingNumberValid, servingSize, servingSizeValid
  ];

  RecipeInteractionState copyWith({
    TextEditingController? ingredientNameTextController,
    TextEditingController? ingredientQuantityTextController,
    TextEditingController? ingredientMeasurementTextController,
    FormzSubmissionStatus? formStatus,
    List<Ingredient>? ingredientList,
    IngredientName? ingredientName,
    IngredientQuantity? ingredientQuantity,
    IngredientMeasurement? ingredientMeasurement,
    ServingNumber? servingNumber,
    ServingSize? servingSize,
    bool? ingredientNameValid,
    bool? ingredientQuantityValid,
    bool? ingredientMeasurementValid,
    bool? servingNumberValid,
    bool? servingSizeValid,
    String? recipeThumbnailPath
  }) {
    return RecipeInteractionState(
      ingredientNameTextController: ingredientNameTextController ?? this.ingredientNameTextController,
      ingredientQuantityTextController: ingredientQuantityTextController ?? this.ingredientQuantityTextController,
      ingredientMeasurementTextController: ingredientMeasurementTextController ?? this.ingredientMeasurementTextController,
      formStatus: formStatus ?? this.formStatus,
      ingredientList: ingredientList ?? this.ingredientList,
      ingredientName: ingredientName ?? this.ingredientName,
      ingredientQuantity: ingredientQuantity ?? this.ingredientQuantity,
      ingredientMeasurement: ingredientMeasurement ?? this.ingredientMeasurement,
      servingNumber: servingNumber ?? this.servingNumber,
      servingSize: servingSize ?? this.servingSize,
      ingredientNameValid: ingredientNameValid ?? this.ingredientNameValid,
      ingredientQuantityValid: ingredientQuantityValid ?? this.ingredientQuantityValid,
      ingredientMeasurementValid: ingredientMeasurementValid ?? this.ingredientMeasurementValid,
      servingNumberValid: servingNumberValid ?? this.servingNumberValid,
      servingSizeValid: servingSizeValid ?? this.servingSizeValid,
      recipeThumbnailPath: recipeThumbnailPath ?? this.recipeThumbnailPath
    );
  }
}