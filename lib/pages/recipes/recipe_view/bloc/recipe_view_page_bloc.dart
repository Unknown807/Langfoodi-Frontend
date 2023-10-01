import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';
import 'package:recipe_social_media/widgets/shared_widgets.dart';

export 'recipe_view_page_bloc.dart';
part 'recipe_view_page_event.dart';
part 'recipe_view_page_state.dart';

class RecipeViewPageBloc extends Bloc<RecipeViewPageEvent, RecipeViewPageState> {
  RecipeViewPageBloc(this._authRepo, this._recipeRepo) : super(const RecipeViewPageState(recipesToDisplay: [])) {
    on<ChangeRecipesToDisplay>(_changeRecipesToDisplay);
  }

  final AuthenticationRepository _authRepo;
  final RecipeRepository _recipeRepo;

  Future<void> _changeRecipesToDisplay(ChangeRecipesToDisplay event, Emitter<RecipeViewPageState> emit) async {
    String? userId = (await _authRepo.currentUser).id;
    List<Recipe> newRecipes = await _recipeRepo.getRecipesFromUserId(userId!);
    List<ScrollItem> scrollableRecipes =  newRecipes.map((recipe) => ScrollItem(recipe.id, "https://daniscookings.com/wp-content/uploads/2021/03/Cinnamon-Roll-Cake-23.jpg", recipe.title)).toList();

    emit(
      state.copyWith(
        recipesToDisplay: scrollableRecipes
      )
    );
  }
}