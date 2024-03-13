import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_social_media/pages/recipes/recipe_view/bloc/recipe_view_bloc.dart';
import 'package:recipe_social_media/repositories/navigation/args/recipe_interaction/recipe_interaction_page_arguments.dart';
import 'package:recipe_social_media/utilities/utilities.dart';
import 'package:recipe_social_media/widgets/shared_widgets.dart';

class RecipeViewPage extends StatelessWidget implements PageLander {
  const RecipeViewPage({super.key});

  @override
  void onLanding(BuildContext context) {
    BlocProvider.of<RecipeViewBloc>(context)
        .add(const ChangeRecipesToDisplay());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecipeViewBloc, RecipeViewState>(
      listener: (context, state) {
        if (state.dialogMessage.isNotEmpty) {
          showDialog(
            context: context,
            builder: (_) => BlocProvider<RecipeViewBloc>.value(
              value: BlocProvider.of<RecipeViewBloc>(context),
              child: CustomAlertDialog(
                title: Text(state.dialogTitle),
                content: Text(state.dialogMessage),
                leftButtonText: null,
                rightButtonCallback: () => context
                  .read<RecipeViewBloc>()
                  .add(const ChangeRecipesToDisplay()),
              )
            )
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: state.recipesToDisplay.isEmpty
            ? AppBar(title: const Text("My Recipes"), backgroundColor: Theme.of(context).primaryColor)
            : CustomSearchAppBar(
                title: const Text("My Recipes"),
                hintText: "Search Your Recipes",
                suggestions: state.searchSuggestions,
                onSearchFunc: (term) => context
                  .read<RecipeViewBloc>()
                  .add(SearchTermChanged(term)),
              ),
          floatingActionButton: CustomFloatingButton(
            key: const Key("recipeViewPage"),
            icon: Icons.add,
            eventFunc: () => context
              .read<RecipeViewBloc>()
              .add(GoToInteractionPageAndExpectResult(
              context, RecipeInteractionPageArguments(
              pageType: RecipeInteractionType.create))
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          body: state.pageLoading
            ? const Center(child: CircularProgressIndicator())
            : Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    BlocBuilder<RecipeViewBloc, RecipeViewState>(
                      builder: (context, state) {
                        return state.recipesToDisplay.isEmpty
                            ? SizedBox(
                                height: MediaQuery.of(context).size.height - 200,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(state.networkIssue ? "Network Issue! Can't Get Recipes" : "No Recipes Yet",
                                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                ),
                              )
                            : ItemScrollPanel(
                                titleFontSize: 22,
                                hasButton: true,
                                buttonIcon: Icon(
                                  Icons.close_rounded,
                                  color: Theme.of(context).colorScheme.inversePrimary
                                ),
                                items: state.recipesToDisplay.where((r) => r.show).toList(),
                                scrollDirection: Axis.vertical,
                                imageAspectRatio: 3/4,
                                onTapButton: (ScrollItem item) => showDialog(
                                  context: context,
                                  builder: (_) => BlocProvider<RecipeViewBloc>.value(
                                    value: BlocProvider.of<RecipeViewBloc>(context),
                                    child: CustomAlertDialog(
                                      title: const Text("Remove Recipe"),
                                      content: Text("Are you sure you want to remove ${item.title}"),
                                      rightButtonText: "Remove",
                                      rightButtonCallback: () => context
                                        .read<RecipeViewBloc>()
                                        .add(RemoveRecipe(item.id)),
                                    )
                                  )
                                ),
                                onTap: (ScrollItem item) => context
                                  .read<RecipeViewBloc>()
                                  .add(GoToInteractionPageAndExpectResult(
                                    context, RecipeInteractionPageArguments(
                                      pageType: RecipeInteractionType.readonly,
                                      recipeId: item.id)
                                  ))
                              );
                    })
                  ],
                ),
              )
          );
      }
    );
  }
}
