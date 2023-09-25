import 'package:equatable/equatable.dart';
import 'package:recipe_social_media/widgets/shared_widgets.dart';

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