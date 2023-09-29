part of 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';

class RecipeStep extends Equatable with JsonConvertible {
  const RecipeStep(this.text, this.imageUrl);

  final String text;
  final String? imageUrl;

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