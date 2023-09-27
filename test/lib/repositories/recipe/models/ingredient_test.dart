import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';
import '../../../../../test_utilities/mocks/generic_mocks.dart';

void main() {
  group("ingredient model tests", () {
    group("toJson method tests", () {
      test("convert model to map", () {
        // Arrange
        const model = Ingredient("eggs", 12, "whole");

        // Act
        final result = model.toJson();

        // Assert
        expect(result, {
          "name": "eggs",
          "quantity": 12.0,
          "unitOfMeasurement": "whole"
        });
      });
    });

    group("fromJson method tests", () {
      test("convert json map to model", () {
        // Arrange
        JsonWrapperMock jsonWrapperMock = JsonWrapperMock();
        const data = {
          "name": "eggs",
          "quantity": 12,
          "unitOfMeasurement": "whole"
        };

        // Act
        final result = Ingredient.fromJson(data, jsonWrapperMock);

        // Assert
        expect(result, const Ingredient("eggs", 12, "whole"));
      });
    });
  });
}