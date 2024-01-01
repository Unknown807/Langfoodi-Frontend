part of 'recipe_view_bloc.dart';

class RecipeViewState extends Equatable {
  const RecipeViewState({
    this.successMessage = "",
    this.recipesToDisplay = const []
  });

  final String successMessage;
  final List<ScrollItem> recipesToDisplay;

  @override
  List<Object?> get props => [recipesToDisplay, successMessage];

  RecipeViewState copyWith({
    String? successMessage,
    List<ScrollItem>? recipesToDisplay
  }) {
    return RecipeViewState(
      successMessage: successMessage ?? this.successMessage,
      recipesToDisplay: recipesToDisplay ?? this.recipesToDisplay
    );
  }
}