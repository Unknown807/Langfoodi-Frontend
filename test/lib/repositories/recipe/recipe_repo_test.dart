import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_social_media/entities/recipe/recipe_entities.dart';
import 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';
import '../../../../test_utilities/mocks/generic_mocks.dart';

void main() {
  late ResponseMock responseMock;
  late RequestMock requestMock;
  late JsonWrapperMock jsonWrapperMock;
  late RecipeRepository sut;

  setUp(() {
    responseMock = ResponseMock();
    requestMock = RequestMock();
    jsonWrapperMock = JsonWrapperMock();

    when(() => requestMock.postWithoutBody(any())).thenAnswer((invocation) => Future.value(responseMock));
    registerFallbackValue(jsonWrapperMock);

    sut = RecipeRepository(requestMock, jsonWrapperMock);
  });

  group("getRecipeById method tests", () {
    test("status code is 200", () async {
      // Arrange
      const recipeId = "1";
      const jsonStr = '{"id":"1","title":"recipe1","description":"recipe 1 desc","chef":{"id":"id1","handler":"testHandler","userName":"test1","accountCreationDate":"2023-11-08","pinnedConversationIds": ["convoId1"]},"numberOfServings":null,"cookingTime":500,"kiloCalories":2000,"tags":["string"],"ingredients":[{"name":"egg","quantity":1,"unitOfMeasurement":"whole"}],"recipeSteps":[{"text":"step 1","imageUrl":"url"}],"creationDate":"2023-09-26T15:50:29.1911738+00:00","lastUpdatedDate":"2023-09-26T15:50:29.1911738+00:00"}';
      when(() => responseMock.statusCode).thenReturn(200);
      when(() => responseMock.body).thenReturn(jsonStr);
      when(() => jsonWrapperMock.decodeData(any())).thenReturn({"id":"1","title":"recipe1","description":"recipe 1 desc","chef":{"id":"id1","handler":"testHandler","userName":"test1","accountCreationDate":"2023-11-08","pinnedConversationIds": ["convoId1"]},"numberOfServings":null,"cookingTime":500,"kiloCalories":2000,"tags":["string"],"ingredients":[{"name":"egg","quantity":1,"unitOfMeasurement":"whole"}],"recipeSteps":[{"text":"step 1","imageUrl":"url"}],"creationDate":"2023-09-26T15:50:29.1911738+00:00","lastUpdatedDate":"2023-09-26T15:50:29.1911738+00:00"});

      // Act
      var result = await sut.getRecipeById(recipeId);

      // Assert
      expect(result, isNotNull);
      expect(result, isA<RecipeDetailed>());
    });

    test("status code is NOT 200", () async {
      // Arrange
      const recipeId = "1";
      when(() => responseMock.statusCode).thenReturn(404);

      // Act
      var result = await sut.getRecipeById(recipeId);

      // Assert
      expect(result, isNull);
    });
  });

  group("getRecipesFromUserId method tests", () {
    test("status code is 200", () async {
      // Arrange
      const userId = "1";
      const jsonStr = '[{"id":"1","title":"recipe1","description":"recipe 1 desc","chefUsername":"test4","tags":["string"],"numberOfServings":null,"cookingTime":500,"kiloCalories":2000,"creationDate":"2023-09-26T15:50:29.1911738+00:00","lastUpdatedDate":"2023-09-26T15:50:29.1911738+00:00"},{"id":"2","title":"title here","description":"desc here","chefUsername":"test4","tags":["lbl1","lbl2"],"numberOfServings":1,"cookingTime":1000,"kiloCalories":null,"creationDate":"2023-09-26T21:16:00.2696909+00:00","lastUpdatedDate":"2023-09-26T21:16:00.2696909+00:00"}]';
      when(() => responseMock.statusCode).thenReturn(200);
      when(() => responseMock.body).thenReturn(jsonStr);
      when(() => jsonWrapperMock.decodeData(any())).thenReturn([{"id":"1","title":"recipe1","description":"recipe 1 desc","chefUsername":"test4","tags":["string"],"numberOfServings":null,"cookingTime":500,"kiloCalories":2000,"creationDate":"2023-09-26T15:50:29.1911738+00:00","lastUpdatedDate":"2023-09-26T15:50:29.1911738+00:00"},{"id":"2","title":"title here","description":"desc here","chefUsername":"test4","tags":["lbl1","lbl2"],"numberOfServings":1,"cookingTime":1000,"kiloCalories":null,"creationDate":"2023-09-26T21:16:00.2696909+00:00","lastUpdatedDate":"2023-09-26T21:16:00.2696909+00:00"}]);

      // Act
      var result = await sut.getRecipesFromUserId(userId);

      // Assert
      expect(result.length, 2);
      expect(result[0], isA<Recipe>());
    });

    test("status code is NOT 200", () async {
      // Arrange
      const userId = "1";
      when(() => responseMock.statusCode).thenReturn(404);

      // Act
      var result = await sut.getRecipesFromUserId(userId);

      // Assert
      expect(result, List.empty());
    });
  });

  group("getRecipesFromUsername method tests", () {
    test("status code is 200", () async {
      // Arrange
      const username = "user1";
      const jsonStr = '[{"id":"1","title":"recipe1","description":"recipe 1 desc","chefUsername":"test4","tags":["string"],"numberOfServings":null,"cookingTime":500,"kiloCalories":2000,"creationDate":"2023-09-26T15:50:29.1911738+00:00","lastUpdatedDate":"2023-09-26T15:50:29.1911738+00:00"},{"id":"2","title":"title here","description":"desc here","chefUsername":"test4","tags":["lbl1","lbl2"],"numberOfServings":1,"cookingTime":1000,"kiloCalories":null,"creationDate":"2023-09-26T21:16:00.2696909+00:00","lastUpdatedDate":"2023-09-26T21:16:00.2696909+00:00"}]';
      when(() => responseMock.statusCode).thenReturn(200);
      when(() => responseMock.body).thenReturn(jsonStr);
      when(() => jsonWrapperMock.decodeData(any())).thenReturn([{"id":"1","title":"recipe1","description":"recipe 1 desc","chefUsername":"test4","tags":["string"],"numberOfServings":null,"cookingTime":500,"kiloCalories":2000,"creationDate":"2023-09-26T15:50:29.1911738+00:00","lastUpdatedDate":"2023-09-26T15:50:29.1911738+00:00"},{"id":"2","title":"title here","description":"desc here","chefUsername":"test4","tags":["lbl1","lbl2"],"numberOfServings":1,"cookingTime":1000,"kiloCalories":null,"creationDate":"2023-09-26T21:16:00.2696909+00:00","lastUpdatedDate":"2023-09-26T21:16:00.2696909+00:00"}]);

      // Act
      var result = await sut.getRecipesFromUsername(username);

      // Assert
      expect(result.length, 2);
      expect(result[0], isA<Recipe>());
    });

    test("status code is NOT 200", () async {
      // Arrange
      const username = "user1";
      when(() => responseMock.statusCode).thenReturn(404);

      // Act
      var result = await sut.getRecipesFromUsername(username);

      // Assert
      expect(result, List.empty());
    });
  });

  group("addNewRecipe method tests", () {
    test("status code is 200", () async {
      // Arrange
      final contract = NewRecipeContract(
          title: "recipe1", description: "recipe 1 desc", chefId: "1",
          tags: ["string"], ingredients: [const Ingredient("eggs", 1, "whole")],
          recipeSteps: [RecipeStep("step 1", "url")]);
      const jsonStr = '{"id":"1","title":"recipe1","description":"recipe 1 desc","chef":{"id":"id1","handler":"testHandler","userName":"test1","accountCreationDate":"2023-11-08","pinnedConversationIds": ["convoId1"]},"numberOfServings":null,"cookingTime":500,"kiloCalories":2000,"tags":["string"],"ingredients":[{"name":"egg","quantity":1,"unitOfMeasurement":"whole"}],"recipeSteps":[{"text":"step 1","imageUrl":"url"}],"creationDate":"2023-09-26T15:50:29.1911738+00:00","lastUpdatedDate":"2023-09-26T15:50:29.1911738+00:00"}';
      when(() => responseMock.statusCode).thenReturn(200);
      when(() => responseMock.body).thenReturn(jsonStr);
      when(() => jsonWrapperMock.decodeData(any())).thenReturn({"id":"1","title":"recipe1","description":"recipe 1 desc","chef":{"id":"id1","handler":"testHandler","userName":"test1","accountCreationDate":"2023-11-08","pinnedConversationIds": ["convoId1"]},"numberOfServings":null,"cookingTime":500,"kiloCalories":2000,"tags":["string"],"ingredients":[{"name":"egg","quantity":1,"unitOfMeasurement":"whole"}],"recipeSteps":[{"text":"step 1","imageUrl":"url"}],"creationDate":"2023-09-26T15:50:29.1911738+00:00","lastUpdatedDate":"2023-09-26T15:50:29.1911738+00:00"});
      when(() => requestMock.post(any(), contract, any())).thenAnswer((invocation) => Future.value(responseMock));

      // Act
      var result = await sut.addNewRecipe(contract);

      // Assert
      expect(result, isNotNull);
      expect(result, isA<RecipeDetailed>());
    });

    test("status code is NOT 200", () async {
      // Arrange
      final contract = NewRecipeContract(
          title: "recipe1", description: "recipe 1 desc", chefId: "1",
          tags: ["string"], ingredients: [const Ingredient("eggs", 1, "whole")],
          recipeSteps: [RecipeStep("step 1", "url")]);
      when(() => responseMock.statusCode).thenReturn(404);
      when(() => requestMock.post(any(), contract, any())).thenAnswer((invocation) => Future.value(responseMock));

      // Act
      var result = await sut.addNewRecipe(contract);

      // Assert
      expect(result, isNull);
    });
  });

  group("updateRecipe method tests", () {
    test("status code is 200", () async {
      // Arrange
      final contract = UpdateRecipeContract(
          title: "recipe1", description: "recipe 1 desc", id: "1",
          tags: ["string"], ingredients: [const Ingredient("eggs", 1, "whole")],
          recipeSteps: [RecipeStep("step 1", "url")]);
      when(() => responseMock.statusCode).thenReturn(200);
      when(() => requestMock.put(any(), contract, any())).thenAnswer((invocation) => Future.value(responseMock));

      // Act
      var result = await sut.updateRecipe(contract);

      // Assert
      expect(result, isNotNull);
      expect(result, isTrue);
    });

    test("status code is NOT 200", () async {
      // Arrange
      final contract = UpdateRecipeContract(
          title: "recipe1", description: "recipe 1 desc", id: "1",
          tags: ["string"], ingredients: [const Ingredient("eggs", 1, "whole")],
          recipeSteps: [RecipeStep("step 1", "url")]);
      when(() => responseMock.statusCode).thenReturn(404);
      when(() => requestMock.put(any(), contract, any())).thenAnswer((invocation) => Future.value(responseMock));

      // Act
      var result = await sut.updateRecipe(contract);

      // Assert
      expect(result, isNotNull);
      expect(result, isFalse);
    });
  });

  group("removeRecipe method tests", () {
    test("status code is 200", () async {
      // Arrange
      const recipeId = "1";
      when(() => responseMock.statusCode).thenReturn(200);
      when(() => requestMock.delete(any())).thenAnswer((invocation) => Future.value(responseMock));

      // Act
      var result = await sut.removeRecipe(recipeId);

      // Assert
      expect(result, isNotNull);
      expect(result, isTrue);
    });

    test("status code is NOT 200", () async {
      // Arrange
      const recipeId = "1";
      when(() => responseMock.statusCode).thenReturn(404);
      when(() => requestMock.delete(any())).thenAnswer((invocation) => Future.value(responseMock));

      // Act
      var result = await sut.removeRecipe(recipeId);

      // Assert
      expect(result, isNotNull);
      expect(result, isFalse);
    });
  });
}