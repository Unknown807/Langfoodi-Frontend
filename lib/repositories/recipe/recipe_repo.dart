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

  Future<RecipeDetailed?> getRecipeById(String id) async {
    var response = await request.postWithoutBody("/recipe/get/id?id=$id");
    if (!response.isOk) return null;

    var jsonRecipe = jsonWrapper.decodeData(response.body);
    return RecipeDetailed.fromJson(jsonRecipe);
  }

  Future<List<Recipe>> _getRecipesFromUser(String path) async {
    var response = await request.postWithoutBody(path);
    if (!response.isOk) return [];

    List<dynamic> jsonRecipes = jsonWrapper.decodeData(response.body);
    List<Recipe> retrievedRecipes = jsonRecipes.map((jsonRecipe) => Recipe.fromJson(jsonRecipe)).toList();
    return retrievedRecipes;
  }

  Future<List<Recipe>> getRecipesFromUserId(String id) async {
    return _getRecipesFromUser("/recipe/get/userid?id=$id");
  }

  Future<List<Recipe>> getRecipesFromUsername(String username) async {
    return _getRecipesFromUser("/recipe/get/username?username=$username");
  }

  Future<RecipeDetailed?> addNewRecipe(NewRecipeContract contract) async {
    var response = await request.post("/recipe/create", contract, jsonWrapper);
    if (!response.isOk) return null;

    var jsonRecipe = jsonWrapper.decodeData(response.body);
    return RecipeDetailed.fromJson(jsonRecipe);
  }

  Future<bool> updateRecipe(UpdateRecipeContract contract) async {
    var response = await request.post("/recipe/update", contract, jsonWrapper);
    return response.isOk;
  }

  Future<bool> removeRecipe(String id) async {
    var response = await request.delete("/recipe/remove?id=$id");
    return response.isOk;
  }
}
