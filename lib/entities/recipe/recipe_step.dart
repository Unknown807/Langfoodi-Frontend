part of 'recipe_entities.dart';

class RecipeStep extends Equatable with JsonConvertible {
  RecipeStep(this.text, this.imageUrl);

  final String text;
  String? imageUrl;

  @override
  List<Object?> get props => [text, imageUrl];

  @override
  Map toJson() {
    return {
      "text": text,
      "imageUrl": imageUrl
    };
  }
  
  static RecipeStep fromJson(Map jsonData) {
    return RecipeStep(jsonData["text"], jsonData["imageUrl"]);
  }
}