import 'package:equatable/equatable.dart';
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
  RecipeRepository();

  Future<RecipeDetailed> getRecipeById(String id) async {
    return Future.value(RecipeDetailed(
        "id",
        "title",
        "desc",
        User.empty,
        const ["labels"],
        const [Ingredient("eggs", 12.0, "whole")],
        const [RecipeStep("step 1", "www.example.com/image")],
        DateTime.parse("18-08-2023"),
        DateTime.parse("18-08-2023")));
  }

  Future<List<Recipe>> getRecipesFromUserId(String id) async {
    return Future.value([Recipe(
      "id",
      "title",
      "desc",
      "chef",
      DateTime.parse("18-08-2023")
    )]);
  }

  Future<List<Recipe>> getRecipesFromUser(String username) async {
    return Future.value([Recipe(
        "id",
        "title",
        "desc",
        "chef",
        DateTime.parse("18-08-2023")
    )]);
  }

  Future<RecipeDetailed> addNewRecipe(Object recipe) {
    return Future.value(RecipeDetailed(
        "id",
        "title",
        "desc",
        User.empty,
        const ["labels"],
        const [Ingredient("eggs", 12.0, "whole")],
        const [RecipeStep("step 1", "www.example.com/image")],
        DateTime.parse("18-08-2023"),
        DateTime.parse("18-08-2023")));
  }

  Future<RecipeDetailed> updateRecipe(Object recipe) {
    return Future.value(RecipeDetailed(
        "id",
        "title",
        "desc",
        User.empty,
        const ["labels"],
        const [Ingredient("eggs", 12.0, "whole")],
        const [RecipeStep("step 1", "www.example.com/image")],
        DateTime.parse("18-08-2023"),
        DateTime.parse("18-08-2023")));
  }
}
