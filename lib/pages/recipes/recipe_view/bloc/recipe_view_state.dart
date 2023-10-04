part of 'recipe_view_bloc.dart';

class RecipeViewState extends Equatable {
  const RecipeViewState({
    this.recipesToDisplay = const []
  });

  final List<ScrollItem> recipesToDisplay;

  @override
  List<Object?> get props => [recipesToDisplay,];

  RecipeViewState copyWith({
    List<ScrollItem>? recipesToDisplay
  }) {
    return RecipeViewState(
        recipesToDisplay: recipesToDisplay ?? this.recipesToDisplay
    );
  }
}