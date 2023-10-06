part of 'recipe_entities.dart';

class Ingredient extends Equatable with JsonConvertible {
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

  static Ingredient fromJson(Map jsonData) {
    return Ingredient(
        jsonData["name"],
        jsonData["quantity"].toDouble(),
        jsonData["unitOfMeasurement"]);
  }
}