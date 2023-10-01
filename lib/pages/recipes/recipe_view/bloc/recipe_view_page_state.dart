part of 'recipe_view_page_bloc.dart';

class RecipeViewPageState extends Equatable {
  const RecipeViewPageState({
    required this.recipesToDisplay
  });

  final List<ScrollItem> recipesToDisplay;

  @override
  List<Object?> get props => [recipesToDisplay,];

  RecipeViewPageState copyWith({
    List<ScrollItem>? recipesToDisplay
  }) {
    return RecipeViewPageState(
        recipesToDisplay: recipesToDisplay ?? this.recipesToDisplay
    );
  }
}