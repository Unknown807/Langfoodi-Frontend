import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:recipe_social_media/pages/recipes/recipe_interaction/bloc/recipe_interaction_event.dart';
import 'package:recipe_social_media/pages/recipes/recipe_interaction/bloc/recipe_interaction_state.dart';
import 'package:recipe_social_media/pages/recipes/recipe_interaction/models/ingredient_name.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';

class RecipeInteractionBloc extends Bloc<RecipeInteractionEvent, RecipeInteractionState> {
  RecipeInteractionBloc(this._authRepo, this._recipeRepo) : super(const RecipeInteractionState()) {
    on<AddNewIngredientFromName>(_addNewIngredientFromName);
  }

  final AuthenticationRepository _authRepo;
  final RecipeRepository _recipeRepo;

  Future<void> _addNewIngredientFromName(AddNewIngredientFromName event, Emitter<RecipeInteractionState> emit) async {
    final ingredientName = IngredientName.dirty(event.name);
    print(state.ingredientName);
    print(ingredientName);

    emit(
      state.copyWith(
        ingredientName: ingredientName,
        ingredientNameValid: Formz.validate([ingredientName])
      )
    );
  }
}