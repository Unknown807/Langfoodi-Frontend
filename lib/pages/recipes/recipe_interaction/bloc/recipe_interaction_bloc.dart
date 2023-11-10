import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:recipe_social_media/entities/recipe/recipe_entities.dart';
import 'package:recipe_social_media/pages/recipes/recipe_interaction/models/recipe_interaction_models.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';

export 'recipe_interaction_bloc.dart';
part 'recipe_interaction_event.dart';
part 'recipe_interaction_state.dart';

class RecipeInteractionBloc extends Bloc<RecipeInteractionEvent, RecipeInteractionState> {
  RecipeInteractionBloc(this._authRepo, this._recipeRepo) : super(RecipeInteractionState(
    ingredientNameTextController: TextEditingController(),
    ingredientQuantityTextController: TextEditingController(),
    ingredientMeasurementTextController: TextEditingController(),
    servingNumberTextController: TextEditingController(),
    servingSizeTextController: TextEditingController(),
    kilocaloriesTextController: TextEditingController(),
    cookingTimeTextController: TextEditingController(),
    cookingTimeHiddenTextController: TextEditingController(),
    recipeStepDescriptionTextController: TextEditingController(),
    recipeTagTextController: TextEditingController()
  )) {
    on<AddNewIngredientFromName>(_addNewIngredientFromName);
    on<AddNewIngredientFromQuantity>(_addNewIngredientFromQuantity);
    on<AddNewIngredientFromMeasurement>(_addNewIngredientFromMeasurement);
    on<IngredientNameChanged>(_ingredientNameChanged);
    on<IngredientQuantityChanged>(_ingredientQuantityChanged);
    on<IngredientMeasurementChanged>(_ingredientMeasurementChanged);
    on<RemoveIngredient>(_removeIngredient);
    on<RemoveRecipeStep>(_removeRecipeStep);
    on<ServingNumberChanged>(_servingNumberChanged);
    on<ServingSizeChanged>(_servingSizeChanged);
    on<KilocaloriesChanged>(_kilocaloriesChanged);
    on<CookingTimeChanged>(_cookingTimeChanged);
    on<RecipeThumbnailPicked>(_recipeThumbnailPicked);
    on<RecipeStepImagePicked>(_recipeStepImagePicked);
    on<RecipeStepDescriptionChanged>(_recipeStepDescriptionChanged);
    on<AddNewRecipeStepFromDescription>(_addNewRecipeStepFromDescription);
    on<ReorderRecipeStepList>(_reorderRecipeStepList);
    on<AddNewRecipeTagFromField>(_addNewTagFromField);
    on<AddNewRecipeTagFromButton>(_addNewTagFromButton);
    on<RecipeTagChanged>(_recipeTagChanged);
    on<RemoveRecipeTag>(_removeRecipeTag);
  }

  final AuthenticationRepository _authRepo;
  final RecipeRepository _recipeRepo;

  void _removeRecipeTag(RemoveRecipeTag event, Emitter<RecipeInteractionState> emit) {
    if (event.index >= 0 && event.index <= state.recipeTagList.length) {
      List<String> recipeTagsList = List.from(state.recipeTagList);
      recipeTagsList.removeAt(event.index);
      emit(state.copyWith(
          recipeTagList: recipeTagsList
      ));
    }
  }

  void _recipeTagChanged(RecipeTagChanged event, Emitter<RecipeInteractionState> emit) {
    final recipeTag = RecipeTag.dirty(event.tag);

    emit(
      state.copyWith(
        recipeTag: recipeTag,
        recipeTagValid: Formz.validate([recipeTag])
      )
    );
  }

  void _addNewTagFromButton(AddNewRecipeTagFromButton event, Emitter<RecipeInteractionState> emit) {
    _addNewTag(state.recipeTagTextController.value.text);
  }

  void _addNewTagFromField(AddNewRecipeTagFromField event, Emitter<RecipeInteractionState> emit) {
    _addNewTag(event.tag);
  }

  void _addNewTag(String tag) {
    final recipeTag = RecipeTag.dirty(tag);
    final tagNotInList = state
        .recipeTagList
        .where((tag) => tag.toLowerCase() == recipeTag.value.toLowerCase())
        .isEmpty;

    if (Formz.validate([recipeTag]) && tagNotInList) {
      List<String> tagsList = List.from(state.recipeTagList);
      tagsList.add(tag);

      emit(
          state.copyWith(
            recipeTag: const RecipeTag.pure(),
            recipeTagList: tagsList,
            recipeTagValid: true
          )
      );

      state.recipeTagTextController.clear();
    } else {
      emit(
          state.copyWith(
            recipeTag: recipeTag,
            recipeTagValid: false
          )
      );
    }
  }

  void _reorderRecipeStepList(ReorderRecipeStepList event, Emitter<RecipeInteractionState> emit) {
    final oldIndex = event.oldIndex;
    var newIndex = event.newIndex;
    if (oldIndex < newIndex) newIndex--;

    List<RecipeStep> recipeStepsList = List.from(state.recipeStepList);
    final RecipeStep stepToReorder = recipeStepsList.removeAt(oldIndex);
    recipeStepsList.insert(newIndex, stepToReorder);

    emit(
      state.copyWith(
        recipeStepList: recipeStepsList
      )
    );
  }

  void _addNewRecipeStepFromDescription(AddNewRecipeStepFromDescription event, Emitter<RecipeInteractionState> emit) {
    final recipeStepDescription = RecipeStepDescription.dirty(event.description);
    final recipeStepDescriptionValid = Formz.validate([recipeStepDescription]);

    if (recipeStepDescriptionValid && state.recipeStepImagePath.isNotEmpty) {
      List<RecipeStep> recipeStepsList = List.from(state.recipeStepList);
      recipeStepsList.add(RecipeStep(recipeStepDescription.value, state.recipeStepImagePath));

      emit(
        state.copyWith(
          recipeStepImagePath: "",
          recipeStepDescription: const RecipeStepDescription.pure(),
          recipeStepList: recipeStepsList
        )
      );

      state.recipeStepDescriptionTextController.clear();
    } else {
      emit(
        state.copyWith(
          recipeStepDescription: recipeStepDescription,
          recipeStepDescriptionValid: recipeStepDescriptionValid
        )
      );
    }
  }

  void _recipeStepDescriptionChanged(RecipeStepDescriptionChanged event, Emitter<RecipeInteractionState> emit) {
    final recipeStepDescription = RecipeStepDescription.dirty(event.description);

    emit(state.copyWith(
        recipeStepDescription: recipeStepDescription,
        recipeStepDescriptionValid: Formz.validate([recipeStepDescription])
    ));
  }

  void _recipeStepImagePicked(RecipeStepImagePicked event, Emitter<RecipeInteractionState> emit) {
    emit(
      state.copyWith(
        recipeStepImagePath: event.imagePath
      )
    );
  }

  void _recipeThumbnailPicked(RecipeThumbnailPicked event, Emitter<RecipeInteractionState> emit) {
    emit(
        state.copyWith(
            recipeThumbnailPath: event.imagePath
        )
    );
  }

  void _cookingTimeChanged(CookingTimeChanged event, Emitter<RecipeInteractionState> emit) {
    bool backspaceUsed = state.cookingTime.value.length > event.cookingTime.length;
    if (backspaceUsed) {
      state.cookingTimeTextController.text = state.cookingTime.value;
      return;
    }

    String currentHiddenText = state.cookingTimeHiddenTextController.value.text;
    if (currentHiddenText.length > 5) {
      currentHiddenText = currentHiddenText.substring(1, 6);
    }

    state.cookingTimeHiddenTextController.text =
        currentHiddenText+event.cookingTime.substring(event.cookingTime.length - 1);
    final String newHiddenText = state.cookingTimeHiddenTextController.value.text;

    String formattedCookingTime = event.cookingTime;
    final List<String> chs = newHiddenText.split("");
    chs.insertAll(0, List.filled(6-chs.length, "0"));
    if (chs.length > 6) chs.sublist(0, 6);
    formattedCookingTime = "${chs[0]}${chs[1]}:${chs[2]}${chs[3]}:${chs[4]}${chs[5]}";

    final cookingTime = CookingTime.dirty(formattedCookingTime);
    emit(state.copyWith(
      cookingTime: cookingTime,
      cookingTimeValid: Formz.validate([cookingTime])
    ));
    state.cookingTimeTextController.text = formattedCookingTime;
  }

  void _kilocaloriesChanged(KilocaloriesChanged event, Emitter<RecipeInteractionState> emit) {
    final kilocalories = Kilocalories.dirty(event.kilocalories);

    emit(state.copyWith(
      kilocalories: kilocalories,
      kilocaloriesValid: Formz.validate([kilocalories])
    ));
  }

  void _servingSizeChanged(ServingSizeChanged event, Emitter<RecipeInteractionState> emit) {
    final servingSize = ServingSize.dirty(event.servingSize);
    
    emit(state.copyWith(
      servingSize: servingSize,
      servingSizeValid: Formz.validate([servingSize])
    ));
  }

  void _servingNumberChanged(ServingNumberChanged event, Emitter<RecipeInteractionState> emit) {
    final servingNumber = ServingNumber.dirty(event.servingNumber);

    emit(state.copyWith(
      servingNumber: servingNumber,
      servingNumberValid: Formz.validate([servingNumber])
    ));
  }

  void _removeIngredient(RemoveIngredient event, Emitter<RecipeInteractionState> emit) {
    if (event.index >= 0 && event.index <= state.ingredientList.length) {
      List<Ingredient> ingredientsList = List.from(state.ingredientList);
      ingredientsList.removeAt(event.index);
      emit(state.copyWith(
        ingredientList: ingredientsList
      ));
    }
  }

  void _removeRecipeStep(RemoveRecipeStep event, Emitter<RecipeInteractionState> emit) {
    if (event.index >= 0 && event.index <= state.recipeStepList.length) {
      List<RecipeStep> recipeStepsList = List.from(state.recipeStepList);
      recipeStepsList.removeAt(event.index);
      emit(state.copyWith(
        recipeStepList: recipeStepsList
      ));
    }
  }

  void _ingredientNameChanged(IngredientNameChanged event, Emitter<RecipeInteractionState> emit) {
    final name = IngredientName.dirty(event.name);

    emit(state.copyWith(
      ingredientName: name,
      ingredientNameValid: Formz.validate([name])
    ));
  }

  void _ingredientQuantityChanged(IngredientQuantityChanged event, Emitter<RecipeInteractionState> emit) {
    final quantity = IngredientQuantity.dirty(event.quantity);

    emit(state.copyWith(
        ingredientQuantity: quantity,
        ingredientQuantityValid: Formz.validate([quantity])
    ));
  }

  void _ingredientMeasurementChanged(IngredientMeasurementChanged event, Emitter<RecipeInteractionState> emit) {
    final measurement = IngredientMeasurement.dirty(event.measurement);

    emit(state.copyWith(
        ingredientMeasurement: measurement,
        ingredientMeasurementValid: Formz.validate([measurement])
    ));
  }

  void _addNewIngredientFromName(AddNewIngredientFromName event, Emitter<RecipeInteractionState> emit) {
    _addNewIngredient(
        event.name,
        state.ingredientQuantity.value,
        state.ingredientMeasurement.value);
  }

  void _addNewIngredientFromQuantity(AddNewIngredientFromQuantity event, Emitter<RecipeInteractionState> emit) {
    _addNewIngredient(
        state.ingredientName.value,
        event.quantity,
        state.ingredientMeasurement.value);
  }

  void _addNewIngredientFromMeasurement(AddNewIngredientFromMeasurement event, Emitter<RecipeInteractionState> emit) {
    _addNewIngredient(
        state.ingredientName.value,
        state.ingredientQuantity.value,
        event.measurement);
  }

  void _addNewIngredient(String ingredientName, String ingredientQuantity, String ingredientMeasurement) {
    final name = IngredientName.dirty(ingredientName);
    final quantity = IngredientQuantity.dirty(ingredientQuantity);
    final measurement = IngredientMeasurement.dirty(ingredientMeasurement);
    final quantityValid = Formz.validate([quantity]);
    final measurementValid = Formz.validate([measurement]);
    final nameValid = Formz.validate([name])
        && state.ingredientList
            .where((ing) => ing.name.toLowerCase() == name.value.toLowerCase())
            .isEmpty;

    if (nameValid && quantityValid && measurementValid) {
      List<Ingredient> ingredientsList = List.from(state.ingredientList);
      ingredientsList.add(Ingredient(name.value, double.tryParse(quantity.value)!, measurement.value));

      emit(state.copyWith(
        ingredientName: const IngredientName.pure(),
        ingredientQuantity: const IngredientQuantity.pure(),
        ingredientMeasurement: const IngredientMeasurement.pure(),
        ingredientList: ingredientsList
      ));

      state.ingredientNameTextController.clear();
      state.ingredientQuantityTextController.clear();
      state.ingredientMeasurementTextController.clear();
    } else {
      emit(state.copyWith(
          ingredientName: name,
          ingredientQuantity: quantity,
          ingredientMeasurement: measurement,
          ingredientNameValid: nameValid,
          ingredientQuantityValid: quantityValid,
          ingredientMeasurementValid: measurementValid));
    }
  }
}