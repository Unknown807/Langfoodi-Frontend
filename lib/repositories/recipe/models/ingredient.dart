part of 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';

class Ingredient extends Equatable implements JsonConvertible {
  const Ingredient(this.name, this.quantity, this.unitOfMeasurement);

  final String name;
  final double quantity;
  final String unitOfMeasurement;

  @override
  List<Object?> get props => [name, quantity, unitOfMeasurement];

  @override
  Map toJson() {
    return {
      "name": name,
      "quantity": quantity,
      "unitOfMeasurement": unitOfMeasurement
    };
  }
}