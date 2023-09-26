
import 'package:bloc/bloc.dart';
import 'package:recipe_social_media/pages/recipe_view/bloc/recipe_view_page_event.dart';
import 'package:recipe_social_media/pages/recipe_view/bloc/recipe_view_page_state.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';

class RecipeViewPageBloc extends Bloc<RecipeViewPageEvent, RecipeViewPageState> {
  RecipeViewPageBloc(this._authRepo, this._recipeRepo) : super(const RecipeViewPageState(recipesToDisplay: [])) {
    on<ChangeRecipesToDisplay>(_changeRecipesToDisplay);
  }

  final AuthenticationRepository _authRepo;
  final RecipeRepository _recipeRepo;

  Future<void> _changeRecipesToDisplay(ChangeRecipesToDisplay event, Emitter<RecipeViewPageState> emit) async {
    List<Recipe> newRecipes = await _recipeRepo.getRecipesFromUserId("647b6b439b29dd322771c27f");

    
  }
}