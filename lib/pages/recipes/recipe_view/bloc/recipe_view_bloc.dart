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
  RecipeViewBloc(this._authRepo, this._recipeRepo) : super(const RecipeViewState()) {
    on<ChangeRecipesToDisplay>(_changeRecipesToDisplay);
    on<GoToInteractionPageAndExpectResult>(_goToInteractionPageAndExpectResult);
  }

  final AuthenticationRepository _authRepo;
  final RecipeRepository _recipeRepo;

  Future<void> _goToInteractionPageAndExpectResult(GoToInteractionPageAndExpectResult event, Emitter<RecipeViewState> emit) async {
    BuildContext eventContext = event.context;
    RecipeViewPageArguments? result = await eventContext
      .read<NavigationRepository>()
      .goTo(eventContext, "/recipe-interaction",
        routeType: RouteType.expect,
        arguments: event.arguments) as RecipeViewPageArguments?;

    if (result != null) {
      emit(state.copyWith(successMessage: result.formType));
    }
  }

  Future<void> _changeRecipesToDisplay(ChangeRecipesToDisplay event, Emitter<RecipeViewState> emit) async {
    emit(state.copyWith(pageLoading: true, successMessage: ""));
    String? userId = (await _authRepo.currentUser).id;
    List<Recipe> newRecipes = await _recipeRepo.getRecipesFromUserId(userId!);
    List<ScrollItem> scrollableRecipes =  newRecipes.map((recipe) => ScrollItem(recipe.id, "https://daniscookings.com/wp-content/uploads/2021/03/Cinnamon-Roll-Cake-23.jpg", recipe.title)).toList();

    emit(
      state.copyWith(
        pageLoading: false,
        recipesToDisplay: scrollableRecipes,
      )
    );
  }
}