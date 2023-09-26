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
  static final RecipeRepository _instance = RecipeRepository._internal();

  late Request request;
  late JsonWrapper jsonWrapper;

  RecipeRepository._internal();

  factory RecipeRepository([Request? request, JsonWrapper? jsonWrapper]) {
    _instance.request = request ?? _instance.request;
    _instance.jsonWrapper = jsonWrapper ?? _instance.jsonWrapper;
    return _instance;
  }

  Future<RecipeDetailed> getRecipeById(String id) async {
    throw UnimplementedError();
  }

  Future<List<Recipe>> getRecipesFromUserId(String id) async {
    var response = await request.postWithoutBody("/recipe/get/userid?id=$id");
    if (response.statusCode != 200) return [];

    List<dynamic> jsonRecipes = jsonWrapper.decodeData(response.body);
    List<Recipe> retrievedRecipes = jsonRecipes.map((jsonRecipe) => Recipe.fromJson(jsonRecipe, jsonWrapper)).toList();
    return retrievedRecipes;
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
