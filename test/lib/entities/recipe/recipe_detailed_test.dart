import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_social_media/entities/recipe/recipe_entities.dart';
import 'package:recipe_social_media/entities/user/user.dart';
import '../../../../test_utilities/mocks/generic_mocks.dart';

void main() {
  const jsonMap = {"id": "01","title": "title1","description": "description here","chef": {"id":"01", "userName": "user1", "email": "mail@example.com", "password": "Pass123!"},"labels": ["lbl1", "lbl2"],"ingredients": [{"name": "eggs", "quantity": 12, "unitOfMeasurement": "whole"}],"recipeSteps": [{"text": "step1", "imageUrl": "www.example.com/imgpath"}],"creationDate": "2023-08-18","lastUpdatedDate": "2023-08-18"};

  group("Recipe detailed model tests", () {
    group("fromJson method tests", () {
      test("json map is converted into model", () {
        // Act
        final recipeDetailed = RecipeDetailed.fromJson(jsonMap);

        // Assert
        expect(recipeDetailed, RecipeDetailed(
            "01",
            "title1",
            "description here",
            const User(id: "01", userName: "user1", email: "mail@example.com", password: "Pass123!"),
            const ["lbl1", "lbl2"],
            const [Ingredient("eggs", 12.0, "whole")],
            const [RecipeStep("step1", "www.example.com/imgpath")],
            null, null, null,
            DateTime.parse("2023-08-18"),
            DateTime.parse("2023-08-18")));
      });
    });

    group("fromJsonStr method tests", () {
      test("json string is converted into model", () {
        // Arrange
        const jsonStr = '"{"id": "01","title": "title1","description": "description here","chef": {"id":"01", "userName": "user1", "email": "mail@example.com", "password": "Pass123!"},"labels": ["lbl1", "lbl2"],"ingredients": [{"name": "eggs", "quantity": 12, "unitOfMeasurement": "whole"}],"recipeSteps": [{"text": "step1", "imageUrl": "www.example.com/imgpath"}],"creationDate": "2023-08-18","lastUpdatedDate": "2023-08-18"}"';
        final jsonWrapperMock = JsonWrapperMock();
        when(() => jsonWrapperMock.decodeData(any())).thenReturn(jsonMap);

        // Act
        final recipeDetailed = RecipeDetailed.fromJsonStr(jsonStr, jsonWrapperMock);

        // Assert
        expect(recipeDetailed, RecipeDetailed(
            "01",
            "title1",
            "description here",
            const User(id: "01", userName: "user1", email: "mail@example.com", password: "Pass123!"),
            const ["lbl1", "lbl2"],
            const [Ingredient("eggs", 12.0, "whole")],
            const [RecipeStep("step1", "www.example.com/imgpath")],
            null, null, null,
            DateTime.parse("2023-08-18"),
            DateTime.parse("2023-08-18")));
      });
    });
  });
}