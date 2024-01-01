part of 'recipe_view_bloc.dart';

class RecipeViewState extends Equatable {
  const RecipeViewState({
    this.pageLoading = false,
    this.successMessage = "",
    this.recipesToDisplay = const []
  });

  final bool pageLoading;
  final String successMessage;
  final List<ScrollItem> recipesToDisplay;

  @override
  List<Object?> get props =>
      [recipesToDisplay, successMessage, pageLoading];

  RecipeViewState copyWith({
    bool? pageLoading,
    String? successMessage,
    List<ScrollItem>? recipesToDisplay
  }) {
    return RecipeViewState(
      pageLoading: pageLoading ?? this.pageLoading,
      successMessage: successMessage ?? this.successMessage,
      recipesToDisplay: recipesToDisplay ?? this.recipesToDisplay
    );
  }
}