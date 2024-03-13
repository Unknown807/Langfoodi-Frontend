part of 'package:recipe_social_media/pages/recipes/recipe_interaction/widgets/recipe_interaction_widgets.dart';

class ReadOnlyRecipeMetadataCard extends StatelessWidget {
  const ReadOnlyRecipeMetadataCard(
      {super.key,
      required this.topText,
      required this.mainText,
      required this.bottomText});

  final String topText;
  final String mainText;
  final String bottomText;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(5),
        child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(70)),
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        topText,
                        style: TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      SizedBox(height: 40),
                      Text(
                        mainText,
                        style: TextStyle(fontSize: 35),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      SizedBox(height: 10),
                      Text(
                        bottomText,
                        style: const TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ]))));
  }
}
