import 'package:bloc/bloc.dart';
import 'package:recipe_social_media/pages/recipe_view/bloc/recipe_view_page_event.dart';
import 'package:recipe_social_media/pages/recipe_view/bloc/recipe_view_page_state.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';
import 'package:recipe_social_media/widgets/shared_widgets.dart';

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