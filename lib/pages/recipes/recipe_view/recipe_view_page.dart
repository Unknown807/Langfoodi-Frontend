import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_social_media/pages/recipes/recipe_view/bloc/recipe_view_bloc.dart';
import 'package:recipe_social_media/repositories/navigation/args/recipe_interaction_page_arguments.dart';
import 'package:recipe_social_media/repositories/navigation/navigation_repo.dart';
import 'package:recipe_social_media/utilities/utilities.dart';
import 'package:recipe_social_media/widgets/shared_widgets.dart';

class RecipeViewPage extends StatelessWidget implements PageLander {
  const RecipeViewPage({super.key});

  @override
  void onLanding(BuildContext context) {
    BlocProvider.of<RecipeViewBloc>(context)
        .add(const ChangeRecipesToDisplay());
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
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: CustomTextButton(
                          eventFunc: () => context.read<NavigationRepository>().goTo(context, "/recipe-interaction"),
                          text: "Create", fontSize: 20)
                    ),
                    const Spacer(),
                    Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: CustomTextButton(
                            eventFunc: () {}, text: "+ Filter", fontSize: 20))
                  ]),
                  BlocBuilder<RecipeViewBloc, RecipeViewState>(
                      builder: (context, state) {
                    return state.recipesToDisplay.isEmpty
                        ? Container(
                            height: MediaQuery.of(context).size.height - 200,
                            child: const Align(
                              alignment: Alignment.center,
                              child: Text("No Recipes Yet", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            ),
                          )
                        : ItemScrollPanel(
                            onTap: (ScrollItem item) => context
                                .read<NavigationRepository>()
                                .goTo(context, "/recipe-interaction",
                                  arguments: RecipeInteractionPageArguments(item.id)),
                            items: state.recipesToDisplay
                                .where((r) => r.show)
                                .toList(),
                            scrollDirection: Axis.horizontal,
                            imageAspectRatio:
                                (MediaQuery.of(context).size.width /
                                        MediaQuery.of(context).size.height) +
                                    0.02);
                  })
                ],
              ),
            )));
  }
}

class PlaceholderPage extends StatelessWidget implements PageLander {
  const PlaceholderPage({super.key});

  @override
  void onLanding(BuildContext context) {
    print("Placeholder page here");
  }

  @override
  Widget build(BuildContext context) {
    return const Text("Placeholder page here");
  }
}
