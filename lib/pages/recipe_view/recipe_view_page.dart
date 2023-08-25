import 'package:flutter/material.dart';
import 'package:recipe_social_media/forms/widgets/form_widgets.dart';
import 'package:recipe_social_media/utilities/utilities.dart';
import 'package:recipe_social_media/widgets/shared_widgets.dart';

class RecipeViewPage extends StatelessWidget implements PageLander {
  const RecipeViewPage({super.key});

  @override
  void onLanding() {
    print("Recipe page here");
  }

  SuggestionsBuilder searchBarSuggestions() {
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
            physics: NeverScrollableScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomSearchBar(
                    onChangedFunc: (_) {},
                    hintText: "Search Your Recipes",
                    suggestionsBuilder: searchBarSuggestions()),
                  Container(
                      child: Row(children: <Widget>[
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
                        padding: EdgeInsets.only(right: 5.0),
                        child: CustomTextButton(eventFunc: () {}, text: "+ Filter", fontSize: 20))
                  ])),
                  ItemScrollPanel()
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
