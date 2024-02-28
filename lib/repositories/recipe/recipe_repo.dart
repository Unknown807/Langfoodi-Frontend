import 'dart:io';

import 'package:recipe_social_media/api/api.dart';
import 'package:recipe_social_media/entities/recipe/recipe_entities.dart';
import 'package:recipe_social_media/utilities/utilities.dart';

export 'recipe_repo.dart';
part 'contracts/new_recipe_contract.dart';
part 'contracts/update_recipe_contract.dart';

class RecipeRepository {
  RecipeRepository(this.request, this.jsonWrapper);

  late Request request;
  late JsonWrapper jsonWrapper;

  Future<RecipeDetailed?> getRecipeById(String id) async {
    final response = await request.postWithoutBody("/recipe/get/id?id=$id", headers: { HttpHeaders.authorizationHeader: await request.currentToken });
    if (!response.isOk) return null;

    return RecipeDetailed.fromJsonStr(response.body, jsonWrapper);
  }

  Future<List<Recipe>> _getRecipesFromUser(String path) async {
    final response = await request.postWithoutBody(path, headers: { HttpHeaders.authorizationHeader: await request.currentToken });
    if (!response.isOk) return [];

    List<dynamic> jsonRecipes = jsonWrapper.decodeData(response.body);
    List<Recipe> retrievedRecipes = jsonRecipes
      .map((jsonRecipe) => Recipe.fromJson(jsonRecipe))
      .toList();

    return retrievedRecipes;
  }

  Future<List<Recipe>> getRecipesFromUserId(String id) async {
    return _getRecipesFromUser("/recipe/get/userid?id=$id");
  }

  Future<List<Recipe>> getRecipesFromUsername(String username) async {
    return _getRecipesFromUser("/recipe/get/username?username=$username");
  }

  Future<RecipeDetailed?> addNewRecipe(NewRecipeContract contract) async {
    final response = await request.post("/recipe/create", contract, jsonWrapper, headers: { HttpHeaders.authorizationHeader: await request.currentToken });
    if (!response.isOk) return null;

    return RecipeDetailed.fromJsonStr(response.body, jsonWrapper);
  }

  Future<bool> updateRecipe(UpdateRecipeContract contract) async {
    final response = await request.put("/recipe/update", contract, jsonWrapper, headers: { HttpHeaders.authorizationHeader: await request.currentToken });
    return response.isOk;
  }

  Future<bool> removeRecipe(String id) async {
    final response = await request.delete("/recipe/remove?id=$id", headers: { HttpHeaders.authorizationHeader: await request.currentToken });
    return response.isOk;
  }
}
