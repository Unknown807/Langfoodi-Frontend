import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_social_media/entities/recipe/recipe_entities.dart';

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
        const data = {
          "name": "eggs",
          "quantity": 12,
          "unitOfMeasurement": "whole"
        };

        // Act
        final result = Ingredient.fromJson(data);

        // Assert
        expect(result, const Ingredient("eggs", 12, "whole"));
      });
    });
  });
}