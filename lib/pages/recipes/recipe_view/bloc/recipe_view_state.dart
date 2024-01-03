part of 'recipe_view_bloc.dart';

class RecipeViewState extends Equatable {
  const RecipeViewState({
    this.pageLoading = false,
    this.dialogTitle = "",
    this.dialogMessage = "",
    this.recipesToDisplay = const []
  });

  final bool pageLoading;
  final String dialogTitle;
  final String dialogMessage;
  final List<ScrollItem> recipesToDisplay;

  @override
  List<Object?> get props => [
    recipesToDisplay, dialogTitle,
    pageLoading, dialogMessage
  ];

  RecipeViewState copyWith({
    bool? pageLoading,
    String? dialogTitle,
    String? dialogMessage,
    List<ScrollItem>? recipesToDisplay
  }) {
    return RecipeViewState(
      pageLoading: pageLoading ?? this.pageLoading,
      dialogTitle: dialogTitle ?? this.dialogTitle,
      dialogMessage: dialogMessage ?? this.dialogMessage,
      recipesToDisplay: recipesToDisplay ?? this.recipesToDisplay
    );
  }
}