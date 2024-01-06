part of 'recipe_view_bloc.dart';

class RecipeViewState extends Equatable {
  const RecipeViewState({
    this.pageLoading = false,
    this.dialogTitle = "",
    this.dialogMessage = "",
    this.recipesToDisplay = const [],
    this.searchSuggestions = const [],
    this.prevSearchTerm = "",
  });

  final bool pageLoading;
  final String dialogTitle;
  final String dialogMessage;
  final String prevSearchTerm;
  final List<ScrollItem> recipesToDisplay;
  final List<String> searchSuggestions;

  @override
  List<Object?> get props => [
    recipesToDisplay, dialogTitle,
    pageLoading, dialogMessage,
    searchSuggestions, prevSearchTerm
  ];

  RecipeViewState copyWith({
    bool? pageLoading,
    String? dialogTitle,
    String? dialogMessage,
    List<ScrollItem>? recipesToDisplay,
    List<String>? searchSuggestions,
    String? prevSearchTerm
  }) {
    return RecipeViewState(
      pageLoading: pageLoading ?? this.pageLoading,
      dialogTitle: dialogTitle ?? this.dialogTitle,
      dialogMessage: dialogMessage ?? this.dialogMessage,
      recipesToDisplay: recipesToDisplay ?? this.recipesToDisplay,
      searchSuggestions: searchSuggestions ?? this.searchSuggestions,
      prevSearchTerm: prevSearchTerm ?? this.prevSearchTerm
    );
  }
}