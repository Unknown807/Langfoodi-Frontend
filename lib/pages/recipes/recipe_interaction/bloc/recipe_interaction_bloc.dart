import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:recipe_social_media/entities/recipe/recipe_entities.dart';
import 'package:recipe_social_media/pages/recipes/recipe_interaction/models/recipe_interaction_models.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/image/image_repo.dart';
import 'package:recipe_social_media/repositories/navigation/args/recipe_interaction/recipe_interaction_page_arguments.dart';
import 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';

export 'recipe_interaction_bloc.dart';
part 'recipe_interaction_event.dart';
part 'recipe_interaction_state.dart';

class RecipeInteractionBloc extends Bloc<RecipeInteractionEvent, RecipeInteractionState> {
  RecipeInteractionBloc(this._authRepo, this._recipeRepo, this._imageRepo) : super(RecipeInteractionState(
    ingredientNameTextController: TextEditingController(),
    ingredientQuantityTextController: TextEditingController(),
    ingredientMeasurementTextController: TextEditingController(),
    servingNumberTextController: TextEditingController(),
    servingQuantityTextController: TextEditingController(),
    servingMeasurementTextController: TextEditingController(),
    kilocaloriesTextController: TextEditingController(),
    cookingTimeTextController: TextEditingController(),
    cookingTimeHiddenTextController: TextEditingController(),
    recipeStepDescriptionTextController: TextEditingController(),
    recipeDescriptionTextController: TextEditingController(),
    recipeTitleTextController: TextEditingController(),
    recipeTagTextController: TextEditingController(),
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
    on<ServingQuantityChanged>(_servingQuantityChanged);
    on<ServingMeasurementChanged>(_servingMeasurementChanged);
    on<KilocaloriesChanged>(_kilocaloriesChanged);
    on<CookingTimeChanged>(_cookingTimeChanged);
    on<RecipeThumbnailPicked>(_recipeThumbnailPicked);
    on<RecipeStepImagePicked>(_recipeStepImagePicked);
    on<RecipeStepDescriptionChanged>(_recipeStepDescriptionChanged);
    on<AddNewRecipeStepFromDescription>(_addNewRecipeStepFromDescription);
    on<AddNewRecipeStepFromButton>(_addNewRecipeStepFromButton);
    on<ReorderRecipeStepList>(_reorderRecipeStepList);
    on<RecipeDescriptionChanged>(_recipeDescriptionChanged);
    on<RecipeTitleChanged>(_recipeTitleChanged);
    on<AddNewRecipeTagFromField>(_addNewTagFromField);
    on<AddNewRecipeTagFromButton>(_addNewTagFromButton);
    on<RecipeTagChanged>(_recipeTagChanged);
    on<RemoveRecipeTag>(_removeRecipeTag);
    on<RecipeFormSubmission>(_recipeFormSubmission);
    on<InitState>(_initState);
  }

  final AuthenticationRepository _authRepo;
  final RecipeRepository _recipeRepo;
  final ImageRepository _imageRepo;

  void _initState(InitState event, Emitter<RecipeInteractionState> emit) async {
    if (event.pageType == RecipeInteractionType.create) return;
    emit(state.copyWith(formStatus: FormzSubmissionStatus.inProgress));

    RecipeDetailed? recipe = await _recipeRepo.getRecipeById(event.recipeId!);
    if (recipe == null) {
      return emit(state.copyWith(formStatus: FormzSubmissionStatus.failure));
    }

    state.recipeTitleTextController.text = recipe.title;
    state.recipeDescriptionTextController.text = recipe.description;
    state.servingNumberTextController.text = recipe.numberOfServings?.toString() ?? "";
    state.servingQuantityTextController.text = recipe.servingQuantity?.toString() ?? "";
    state.servingMeasurementTextController.text = recipe.servingUnitOfMeasurement ?? "";
    state.kilocaloriesTextController.text = recipe.kiloCalories?.toString() ?? "";

    CookingTime? cookingTime;
    if (recipe.cookingTime != null) {
      String hours = recipe.cookingTime!.inHours.toString().padLeft(2, "0");
      String minutes = recipe.cookingTime!.inMinutes.remainder(60).toString().padLeft(2, "0");
      String seconds = recipe.cookingTime!.inSeconds.remainder(60).toString().padLeft(2, "0");

      state.cookingTimeHiddenTextController.text = "$hours$minutes$seconds";
      cookingTime = CookingTime.dirty("$hours:$minutes:$seconds");
      state.cookingTimeTextController.text = cookingTime.value;
    }

    emit(state.copyWith(
      recipeThumbnailPath: recipe.thumbnailId,
      recipeTitle: RecipeTitle.dirty(recipe.title),
      recipeDescription: RecipeDescription.dirty(recipe.description),
      recipeTagList: recipe.tags,
      ingredientList: recipe.ingredients,
      recipeStepList: recipe.recipeSteps,
      currentRecipeStepImageIds: recipe.recipeSteps
          .where((rs) => rs.imageUrl != null)
          .map((rs) => rs.imageUrl as String)
          .toList(),
      servingNumber: ServingNumber.dirty(recipe.numberOfServings?.toString() ?? ""),
      servingQuantity: ServingQuantity.dirty(recipe.servingQuantity?.toString() ?? ""),
      servingMeasurement: ServingMeasurement.dirty(recipe.servingUnitOfMeasurement ?? ""),
      kilocalories: Kilocalories.dirty(recipe.kiloCalories?.toString() ?? ""),
      cookingTime: cookingTime,
      currentRecipeId: event.recipeId,
      pageType: event.pageType,
      formStatus: FormzSubmissionStatus.success
    ));
  }

  Future<Map<int, HostedImage?>> _uploadRecipeStepImages(SignedUploadContract contract) async {
    Map<int, HostedImage?> hostedImages = {};
    for (int i = 0 ; i < state.recipeStepList.length ; i++) {
      RecipeStep step = state.recipeStepList[i];
      if (step.imageUrl != null) {
        if (state.pageType == RecipeInteractionType.edit
            && state.currentRecipeStepImageIds.contains(step.imageUrl)) continue;

        HostedImage? recipeStepHostedImage = await _imageRepo
            .uploadImage(step.imageUrl!, contract);

        hostedImages[i] = recipeStepHostedImage;
      }
    }

    return hostedImages;
  }

  Future<HostedImage?> _uploadRecipeThumbnail(SignedUploadContract contract) async {
    HostedImage? recipeThumbnailHosted;
    if (state.recipeThumbnailPath.isNotEmpty) {
      if (state.pageType == RecipeInteractionType.edit
          && state.currentRecipeThumbnailId == state.recipeThumbnailPath) return null;

      recipeThumbnailHosted = await _imageRepo
          .uploadImage(state.recipeThumbnailPath, contract);
    }

    return recipeThumbnailHosted;
  }

  Future<void> _removeHostedImages(HostedImage? recipeThumbnailHosted, Map<int, HostedImage?> hostedImages) async {
    hostedImages[-1] = recipeThumbnailHosted;
    await _imageRepo.removeImages(hostedImages
        .values
        .where((img) => img != null)
        .map((img) => img!.publicId).toList());
  }

  Future<bool> _removeImagesIfUploadError(HostedImage? recipeThumbnailHosted, Map<int, HostedImage?> hostedImages) async {
    bool anyNullHostedImages = hostedImages.values.any((img) => img == null);
    bool thumbnailNotEmpty = state.recipeThumbnailPath.isNotEmpty;

    if (anyNullHostedImages || (recipeThumbnailHosted == null && thumbnailNotEmpty)) {
      await _removeHostedImages(recipeThumbnailHosted, hostedImages);
      return true;
    }

    return false;
  }

  Future<(bool, HostedImage?, Map<int, HostedImage?>)> _attemptFormImageHosting() async {
    Signature? uploadSignature = await _imageRepo.getSignature();
    if (uploadSignature == null) { return (false, null, <int, HostedImage?>{}); }

    final contract = SignedUploadContract(
        uploadSignature.signature,
        uploadSignature.timeStamp);

    Map<int, HostedImage?> hostedImages = await _uploadRecipeStepImages(contract);
    HostedImage? recipeThumbnailHosted = await _uploadRecipeThumbnail(contract);

    bool imageUploadError = await _removeImagesIfUploadError(recipeThumbnailHosted, hostedImages);
    if (imageUploadError) { return (false, null, <int, HostedImage?>{}); }

    return (true, recipeThumbnailHosted, hostedImages);
  }

  bool validateAllFields() {
    // Required Fields
    final recipeDescriptionValid = Formz.validate([state.recipeDescription]);
    final recipeTitleValid = Formz.validate([state.recipeTitle]);
    final recipeStepsValid = state.recipeStepList.isNotEmpty;
    final recipeIngredientsValid = state.ingredientList.isNotEmpty;

    // Optional Fields
    final servingSizeNotEmpty = state.servingQuantity.value.isNotEmpty || state.servingMeasurement.value.isNotEmpty;
    final servingNumberNotEmpty = state.servingNumber.value.isNotEmpty;
    final kilocaloriesNotEmpty = state.kilocalories.value.isNotEmpty;
    final cookingTimeNotEmpty = state.cookingTime.value.isNotEmpty && state.cookingTime.value != "00:00:00";

    final servingQuantityValid = servingSizeNotEmpty ? Formz.validate([state.servingQuantity]) : true;
    final servingMeasurementValid = servingSizeNotEmpty ? Formz.validate([state.servingMeasurement]) : true;
    final servingNumberValid = servingNumberNotEmpty ? Formz.validate([state.servingNumber]) : true;
    final kilocaloriesValid = kilocaloriesNotEmpty ? Formz.validate([state.kilocalories]) : true;
    final cookingTimeValid = cookingTimeNotEmpty ? Formz.validate([state.cookingTime]) : true;

    bool allFieldsValid =
        recipeDescriptionValid && recipeTitleValid
            && recipeStepsValid && recipeIngredientsValid
            && servingQuantityValid && servingMeasurementValid
            && servingNumberValid && kilocaloriesValid
            && cookingTimeValid;

    if (!allFieldsValid) {
      // TODO: maybe add error message to display?
      emit(state.copyWith(
          recipeTitleValid: recipeTitleValid,
          recipeDescriptionValid: recipeDescriptionValid,
          recipeStepDescriptionValid: recipeStepsValid,
          ingredientNameValid: recipeIngredientsValid,
          ingredientQuantityValid: recipeIngredientsValid,
          ingredientMeasurementValid: recipeIngredientsValid,
          servingQuantityValid: servingQuantityValid,
          servingMeasurementValid: servingMeasurementValid,
          servingNumberValid: servingNumberValid,
          kilocaloriesValid: kilocaloriesValid,
          cookingTimeValid: cookingTimeValid,
      ));

      return false;
    }

    return true;
  }

  void _recipeFormSubmission(RecipeFormSubmission event, Emitter<RecipeInteractionState> emit) async {
    if (state.pageType == RecipeInteractionType.create) {
      _recipeCreateFormSubmission();
    } else if (state.pageType == RecipeInteractionType.edit) {
      _recipeEditFormSubmission();
    }
  }

  void _recipeEditFormSubmission() async {
    emit(state.copyWith(formStatus: FormzSubmissionStatus.inProgress));

    if (!validateAllFields()) {
      return emit(state.copyWith(formStatus: FormzSubmissionStatus.failure));
    }

    // Upload new images (if there are any)
    var (hostingSuccess, recipeThumbnailHosted, hostedImages) = await _attemptFormImageHosting();
    if (!hostingSuccess) {
      // TODO: maybe add error message to display?
      return emit(state.copyWith(formStatus: FormzSubmissionStatus.failure));
    }

    // Signature? uploadSignature = await _imageRepo.getSignature();
    // if (uploadSignature == null) {
    //   return emit(state.copyWith(formStatus: FormzSubmissionStatus.failure));
    // }
    //
    // Map<int, HostedImage?> hostedImages = await _uploadRecipeStepImages(SignedUploadContract(
    //     uploadSignature.signature,
    //     uploadSignature.timeStamp));



    // all fields valid
    // upload new images
    // if error -> delete new images

    // make update recipe contract
    // update recipe
    // if false, then recipe update failed, delete new images

    // if true, then recipe update succeeded, so:
    // delete old images
    // if error -> continue and ignore
  }

  void _recipeCreateFormSubmission() async {
    emit(state.copyWith(formStatus: FormzSubmissionStatus.inProgress));

    if (!validateAllFields()) {
      return emit(state.copyWith(formStatus: FormzSubmissionStatus.failure));
    }

    // Upload thumbnail and recipe step images and finalise recipe step list
    var (hostingSuccess, recipeThumbnailHosted, hostedImages) = await _attemptFormImageHosting();
    if (!hostingSuccess) {
      // TODO: maybe add error message to display?
      return emit(state.copyWith(formStatus: FormzSubmissionStatus.failure));
    }

    final List<RecipeStep> finalisedRecipeSteps = [];
    for (int i = 0 ; i < state.recipeStepList.length ; i++) {
      finalisedRecipeSteps.add(RecipeStep(
          state.recipeStepList[i].text,
          hostedImages.containsKey(i) ? hostedImages[i]!.publicId : null)
      );
    }

    // Send recipe creation request to backend
    final servingSizeNotEmpty = state.servingQuantity.value.isNotEmpty || state.servingMeasurement.value.isNotEmpty;
    final servingNumberNotEmpty = state.servingNumber.value.isNotEmpty;
    final kilocaloriesNotEmpty = state.kilocalories.value.isNotEmpty;
    final cookingTimeNotEmpty = state.cookingTime.value.isNotEmpty && state.cookingTime.value != "00:00:00";

    Duration? cookingTimeDuration = cookingTimeNotEmpty
        ? state.cookingTime.getCookingTimeAsDuration()
        : null;

    final userId = (await _authRepo.currentUser).id;

    NewRecipeContract newRecipeContract = NewRecipeContract(
      title: state.recipeTitle.value,
      description: state.recipeDescription.value,
      thumbnailId: recipeThumbnailHosted?.publicId,
      chefId: userId,
      tags: state.recipeTagList,
      ingredients: state.ingredientList,
      recipeSteps: finalisedRecipeSteps,
      cookingTime: cookingTimeDuration,
      kiloCalories: kilocaloriesNotEmpty ? int.parse(state.kilocalories.value) : null,
      numberOfServings: servingNumberNotEmpty ? int.parse(state.servingNumber.value) : null,
      servingQuantity: servingSizeNotEmpty ? double.parse(state.servingQuantity.value) : null,
      servingUnitOfMeasurement: servingSizeNotEmpty ? state.servingMeasurement.value : null
    );

    RecipeDetailed? recipeDetailed = await _recipeRepo.addNewRecipe(newRecipeContract);
    if (recipeDetailed == null) {
      // TODO: maybe add error message to display?
      await _removeHostedImages(recipeThumbnailHosted, hostedImages);
      return emit(state.copyWith(formStatus: FormzSubmissionStatus.failure));
    }

    emit(state.copyWith(formStatus: FormzSubmissionStatus.success));
  }

  void _recipeTitleChanged(RecipeTitleChanged event, Emitter<RecipeInteractionState> emit) {
    final recipeTitle = RecipeTitle.dirty(event.title);
    
    emit(
      state.copyWith(
        recipeTitle: recipeTitle,
        recipeTitleValid: Formz.validate([recipeTitle])
      )
    );
  }

  void _recipeDescriptionChanged(RecipeDescriptionChanged event, Emitter<RecipeInteractionState> emit) {
    final recipeDescription = RecipeDescription.dirty(event.description);
    
    emit(
      state.copyWith(
        recipeDescription: recipeDescription,
        recipeDescriptionValid: Formz.validate([recipeDescription])
      )
    );
  }

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

  void _addNewRecipeStepFromButton(AddNewRecipeStepFromButton event, Emitter<RecipeInteractionState> emit) {
    _addNewRecipeStep(state.recipeStepDescription.value);
  }

  void _addNewRecipeStepFromDescription(AddNewRecipeStepFromDescription event, Emitter<RecipeInteractionState> emit) {
    _addNewRecipeStep(event.description);
  }

  void _addNewRecipeStep(String description) {
    final recipeStepDescription = RecipeStepDescription.dirty(description);
    final recipeStepDescriptionValid = Formz.validate([recipeStepDescription]);

    if (recipeStepDescriptionValid) {
      List<RecipeStep> recipeStepsList = List.from(state.recipeStepList);
      String? recipeStepImagePath = state.recipeStepImagePath.isNotEmpty
        ? state.recipeStepImagePath : null;

      recipeStepsList.add(RecipeStep(recipeStepDescription.value, recipeStepImagePath));

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

  void _servingQuantityChanged(ServingQuantityChanged event, Emitter<RecipeInteractionState> emit) {
    _servingSizeChanged(event.quantity, state.servingMeasurement.value);
  }

  void _servingMeasurementChanged(ServingMeasurementChanged event, Emitter<RecipeInteractionState> emit) {
    _servingSizeChanged(state.servingQuantity.value, event.measurement);
  }

  void _servingSizeChanged(String quantity, String measurement) {
    final servingQuantity = ServingQuantity.dirty(quantity);
    final servingMeasurement = ServingMeasurement.dirty(measurement);

    emit(state.copyWith(
      servingQuantity: servingQuantity,
      servingMeasurement: servingMeasurement,
      servingQuantityValid: Formz.validate([servingQuantity]),
      servingMeasurementValid: Formz.validate([servingMeasurement])
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
