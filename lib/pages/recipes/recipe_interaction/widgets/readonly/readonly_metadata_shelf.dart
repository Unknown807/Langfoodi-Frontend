part of 'package:recipe_social_media/pages/recipes/recipe_interaction/widgets/recipe_interaction_widgets.dart';

class ReadOnlyRecipeMetadataShelf extends StatelessWidget {
  const ReadOnlyRecipeMetadataShelf({
    super.key,
    required this.cards
  });

  final List<ReadOnlyRecipeMetadataCard> cards;

  @override
  Widget build(BuildContext context) {
    cards.removeWhere((card) => card.mainText == "");

    switch(cards.length){
      case(0):
        return Container();

      case(1):
        return Center(child:cards[0]);

      default:
        return (Wrap(spacing:10, children: cards));
    }
  }
}