import 'package:flutter/material.dart';
import 'package:recipe_social_media/utilities/utilities.dart';
import 'package:recipe_social_media/widgets/shared_widgets.dart';

class RecipeViewPage extends StatelessWidget implements PageLander {
  RecipeViewPage({super.key});

  List<ScrollItem> displayRecipes = [
    const ScrollItem(
        "https://daniscookings.com/wp-content/uploads/2021/03/Cinnamon-Roll-Cake-23.jpg",
        "cake", subtitle: "existing subtitle"),
    const ScrollItem(
        "https://anitalianinmykitchen.com/wp-content/uploads/2018/04/vertical-cake-sq-1-of-1.jpg",
        "really long recipe name wow!!!!", subtitle: "wow subtitle"),
    const ScrollItem(
        "https://embed.widencdn.net/img/beef/pygmsl7od0/1120x560px/rancher-recipe-balsamic-steak-pasta-horizontal.tif?keep=c&u=7fueml",
        "Epic name here", show: false),
    const ScrollItem(
        "https://sallysbakingaddiction.com/wp-content/uploads/2019/07/vertical-layer-cake.jpg",
        "Is this the one with steak or nah? or am I trippin?"),
  ];

  @override
  void onLanding() {
    print("Recipe page here");
  }

  SuggestionsBuilder searchBarSuggestionsBuilder() {
    return (BuildContext context, SearchController controller) {
      return List<ListTile>.generate(5, (int index) {
        final String item = 'item $index';
        return ListTile(
          title: Text(item),
          onTap: () {
            print("thing tapped ???");
          },
        );
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomSearchBar(
                    onChangedFunc: (_) {},
                    hintText: "Search Your Recipes",
                    suggestionsBuilder: searchBarSuggestionsBuilder()),
                  Row(children: <Widget>[
                    const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text("Your Recipes",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.normal)),
                    ),
                    const Spacer(),
                    Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: CustomTextButton(eventFunc: () {}, text: "+ Filter", fontSize: 20))
                  ]),
                  ItemScrollPanel(
                      items: displayRecipes.where((r) => r.show).toList(),
                      scrollDirection: Axis.horizontal,
                      imageAspectRatio: (MediaQuery.of(context).size.width / MediaQuery.of(context).size.height) + 0.02)
                ],
              ),
            )));
  }
}

class PlaceholderPage extends StatelessWidget implements PageLander {
  const PlaceholderPage({super.key});

  @override
  void onLanding() {
    print("Placeholder page here");
  }

  @override
  Widget build(BuildContext context) {
    return const Text("Placeholder page here");
  }
}
