import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_social_media/entities/recipe/recipe_entities.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/navigation/args/recipe_interaction/recipe_interaction_page_arguments.dart';
import 'package:recipe_social_media/repositories/navigation/args/recipe_view/recipe_view_page_arguments.dart';
import 'package:recipe_social_media/repositories/navigation/navigation_repo.dart';
import 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';
import 'package:recipe_social_media/widgets/shared_widgets.dart';

export 'recipe_view_bloc.dart';
part 'recipe_view_event.dart';
part 'recipe_view_state.dart';

class RecipeViewBloc extends Bloc<RecipeViewEvent, RecipeViewState> {
  RecipeViewBloc(this._authRepo, this._navigationRepo, this._recipeRepo) : super(const RecipeViewState()) {
    on<ChangeRecipesToDisplay>(_changeRecipesToDisplay);
    on<GoToInteractionPageAndExpectResult>(_goToInteractionPageAndExpectResult);
    on<RemoveRecipe>(_removeRecipe);
    on<SearchTermChanged>(_searchTermChanged);
  }

  final NavigationRepository _navigationRepo;
  final AuthenticationRepository _authRepo;
  final RecipeRepository _recipeRepo;

  void _removeRecipe(RemoveRecipe event, Emitter<RecipeViewState> emit) async {
    emit(state.copyWith(pageLoading: true));

    bool removed = await _recipeRepo.removeRecipe(event.recipeId);

    if (removed) {
      emit(state.copyWith(
        dialogTitle: "Recipe Removed!",
        dialogMessage: "Recipe was successfully removed"
      ));
    } else {
      emit(state.copyWith(
        dialogTitle: "Oops!",
        dialogMessage: "Something went wrong, recipe was not removed"
      ));
    }
  }

  void _goToInteractionPageAndExpectResult(GoToInteractionPageAndExpectResult event, Emitter<RecipeViewState> emit) async {
    BuildContext eventContext = event.context;
    RecipeViewPageArguments? result = await _navigationRepo.goTo(
      eventContext,
      "/recipe-interaction",
      routeType: RouteType.expect,
      arguments: event.arguments) as RecipeViewPageArguments?;

    if (result != null) {
      emit(state.copyWith(
        dialogTitle: result.dialogTitle,
        dialogMessage: result.dialogMessage)
      );
    }
  }

  void _searchTermChanged(SearchTermChanged event, Emitter<RecipeViewState> emit) async {
    List<ScrollItem> scrollableRecipes = List.from(state.recipesToDisplay);
    final searchTerm = event.searchTerm.toLowerCase();
    List<String> newSuggestions = [];

    for (var recipe in scrollableRecipes) {
      if (searchTerm.isEmpty) {
        recipe.show = true;
      } else if (!recipe.title.toLowerCase().contains(searchTerm)) {
        recipe.show = false;
      } else {
        if (newSuggestions.length < 5) {
          newSuggestions.add(recipe.title);
        }
      }
    }

    emit(state.copyWith(
      recipesToDisplay: scrollableRecipes,
      searchSuggestions: newSuggestions
    ));
  }

  void _changeRecipesToDisplay(ChangeRecipesToDisplay event, Emitter<RecipeViewState> emit) async {
    emit(state.copyWith(pageLoading: true, dialogTitle: "", dialogMessage: ""));

    String? userId = (await _authRepo.currentUser).id;
    List<Recipe> newRecipes = await _recipeRepo.getRecipesFromUserId(userId!);
    List<ScrollItem> scrollableRecipes = newRecipes.map(
      (recipe) => ScrollItem(recipe.id, recipe.title, urlImage: recipe.thumbnailId)
    ).toList();

    emit(
      state.copyWith(
        pageLoading: false,
        recipesToDisplay: scrollableRecipes,
      )
    );
  }
}