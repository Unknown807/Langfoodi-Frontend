import 'package:equatable/equatable.dart';
import 'package:recipe_social_media/api/api.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/utilities/utilities.dart';

export 'recipe_repo.dart';
part 'models/ingredient.dart';
part 'models/recipe.dart';
part 'models/recipe_detailed.dart';
part 'models/recipe_step.dart';
part 'contracts/new_recipe_contract.dart';
part 'contracts/update_recipe_contract.dart';

class RecipeRepository {
  RecipeRepository(this.request, this.jsonWrapper);

  final Request request;
  final JsonWrapper jsonWrapper;

  Future<RecipeDetailed> getRecipeById(String id) async {
    throw UnimplementedError();
  }

  Future<List<Recipe>> getRecipesFromUserId(String id) async {
    var response = await request.postWithoutBody("/recipe/get/userid?id=$id");
    var jsonRecipes = jsonWrapper.decodeData(response.body);
    //List<Recipe> recipes = jsonRecipes

    return [];
  }

  Future<List<Recipe>> getRecipesFromUser(String username) async {
    throw UnimplementedError();
  }

  Future<RecipeDetailed> addNewRecipe(Object recipe) {
    throw UnimplementedError();
  }

  Future<bool> updateRecipe(Object recipe) {
    throw UnimplementedError();
  }

  Future<bool> removeRecipe(String id) async {
    throw UnimplementedError();
  }

}
