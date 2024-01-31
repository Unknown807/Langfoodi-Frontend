part of 'recipe_entities.dart';

class RecipePreview extends Equatable with JsonConvertible {
  const RecipePreview(this.id, this.title, this.thumbnailId);

  final String id;
  final String title;
  final String? thumbnailId;

  static RecipePreview fromJson(Map jsonData) {
    return RecipePreview(
      jsonData["id"],
      jsonData["title"],
      jsonData["thumbnailId"]
    );
  }

  @override
  List<Object?> get props => [ id, title, thumbnailId ];
}