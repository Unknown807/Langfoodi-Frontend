import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:recipe_social_media/pages/recipes/recipe_interaction/bloc/recipe_interaction_bloc.dart';
import 'package:recipe_social_media/pages/recipes/recipe_interaction/recipe_interaction_page_constants.dart';
import 'package:recipe_social_media/pages/recipes/recipe_interaction/widgets/recipe_interaction_widgets.dart' as riw;
import 'package:recipe_social_media/pages/recipes/recipe_interaction/widgets/recipe_interaction_widgets.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/image/image_repo.dart';
import 'package:recipe_social_media/repositories/navigation/args/recipe_interaction/recipe_interaction_page_arguments.dart';
import 'package:recipe_social_media/repositories/navigation/args/recipe_interaction/recipe_interaction_page_response_arguments.dart';
import 'package:recipe_social_media/repositories/navigation/navigation_repo.dart';
import 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';
import 'package:recipe_social_media/utilities/utilities.dart';
import 'package:recipe_social_media/widgets/shared_widgets.dart';

class RecipeInteractionPage extends StatelessWidget {
  const RecipeInteractionPage({super.key});

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments;

    RecipeInteractionType pageType = RecipeInteractionType.create;
    String? recipeId;

    if (args != null) {
      args = args as RecipeInteractionPageArguments;
      pageType = args.pageType;
      recipeId = args.recipeId;
    }

    return BlocProvider<RecipeInteractionBloc>(
        create: (_) => RecipeInteractionBloc(
            context.read<AuthenticationRepository>(),
            context.read<RecipeRepository>(),
            context.read<ImageRepository>(),
            context.read<NetworkManager>())
          ..add(InitState(pageType, recipeId)),
        child: BlocConsumer<RecipeInteractionBloc, RecipeInteractionState>(
            listener: (context, state) {
              if (state.formStatus.isFailure) {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) => BlocProvider<RecipeInteractionBloc>.value(
                        value: BlocProvider.of<RecipeInteractionBloc>(context),
                        child: CustomAlertDialog(
                            title: const Text("Oops!"),
                            content: Text(state.formErrorMessage),
                            leftButtonText: null,
                            rightButtonCallback: () => context
                                .read<RecipeInteractionBloc>()
                                .add(const ResetFormStatus()))));
              } else if (state.formStatus.isSuccess) {
                final formType = state.pageType == RecipeInteractionType.create
                    ? "created"
                    : "updated";

                context.read<NavigationRepository>().goTo(
                    context, "/recipe-view",
                    routeType: RouteType.backLink,
                    arguments: RecipeInteractionPageResponseArguments(
                        dialogTitle: "Success!",
                        dialogMessage:
                            "${state.recipeTitle.value} successfully $formType"));
              }
            },
            buildWhen: (p, c) =>
                p.formStatus != c.formStatus || p.pageType != c.pageType,
            builder: (context, state) {
              bool readonly = state.pageType == RecipeInteractionType.readonly;
              return state.formStatus.isInProgress
                  ? const Scaffold(
                      body: Center(child: CircularProgressIndicator()))
                  : Scaffold(
                      appBar: AppBar(
                        backgroundColor:
                            Theme.of(context).colorScheme.background,
                        elevation: 0.5,
                        title: const riw.RecipeTitleInput(),
                        leading: const riw.RecipeBackButton(),
                        actions: readonly
                            ? <Widget>[
                                state.recipeOwned
                                    ? const riw.RecipeEnableEditButton()
                                    : const SizedBox(width: 50)
                              ]
                            : const <Widget>[riw.RecipeSubmitButton()],
                      ),
                      resizeToAvoidBottomInset: false,
                      body: SingleChildScrollView(
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 10, 20,
                                  MediaQuery.of(context).viewInsets.bottom),
                              child: Column(
                                children: <Widget>[
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: readonly
                                          ? const riw.ReadOnlyRecipeTitle()
                                          : null),
                                  Row(children: <Widget>[
                                    Expanded(
                                        child: readonly
                                            ? const riw
                                                .ReadonlyRecipeThumbnail()
                                            : const riw.RecipeThumbnailPicker())
                                  ]),
                                  const Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: RecipeDescriptionInput()),
                                  Container(
                                      child: readonly
                                          ? ReadOnlyRecipeMetadataShelf(
                                              cards: [
                                                riw.ReadOnlyRecipeMetadataCard(
                                                    topText: "Cooking time",
                                                    mainText: state.cookingTime
                                                                .value ==
                                                            ""
                                                        ? state
                                                            .cookingTime.value
                                                        : TextFormatter
                                                            .cookingTimeFormatter(
                                                                state
                                                                    .cookingTime
                                                                    .value),
                                                    ),
                                                riw.ReadOnlyRecipeMetadataCard(
                                                    topText: "Servings",
                                                    mainText: state
                                                        .servingNumber.value,
                                                    bottomText: TextFormatter
                                                        .servingInformationFormatter(
                                                            state.servingNumber
                                                                .value,
                                                            state
                                                                .servingQuantity
                                                                .value,
                                                            state
                                                                .servingMeasurement
                                                                .value,
                                                            state.kilocalories
                                                                .value))
                                              ],
                                            )
                                          : null),
                                  Container(
                                      child: state.recipeTagList.isNotEmpty ||
                                              !readonly
                                          ? ExpansionTile(
                                              initiallyExpanded: true,
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .trailing,
                                              title: Text(
                                                'Tags',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onBackground),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                              children: [
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 10),
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .stretch,
                                                        children: <Widget>[
                                                          readonly
                                                              ? const SizedBox()
                                                              : const riw.RecipeTagInput(),
                                                          const Padding(
                                                              padding: EdgeInsets.only(top: 10),
                                                              child: riw.RecipeTagList())
                                                        ])),
                                              ],
                                            )
                                          : null),
                                  ExpansionTile(
                                    initiallyExpanded: true,
                                    controlAffinity:
                                        ListTileControlAffinity.trailing,
                                    title: Text(
                                      'Ingredients',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    children: [
                                      readonly
                                          ? const SizedBox()
                                          : const SizedBox(
                                              height:
                                                  RecipeInteractionPageConstants
                                                      .sizedBoxHeight,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Flexible(
                                                      flex: 2,
                                                      child: riw
                                                          .IngredientNameInput()),
                                                  Flexible(
                                                      flex: 1,
                                                      child: riw
                                                          .IngredientQuantityInput()),
                                                  Flexible(
                                                      flex: 2,
                                                      child: riw
                                                          .IngredientMeasurementInput()),
                                                  Flexible(
                                                      flex: 0,
                                                      child: riw
                                                          .IngredientSubmitButton())
                                                ],
                                              )),
                                      readonly
                                          ? const riw.ReadonlyIngredientList()
                                          : const riw.IngredientList()
                                    ],
                                  ),
                                  ExpansionTile(
                                    initiallyExpanded: true,
                                    controlAffinity:
                                        ListTileControlAffinity.trailing,
                                    title: Text(
                                      'Recipe Steps',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    children: [
                                      readonly
                                          ? const SizedBox()
                                          : const SizedBox(
                                              height: 100,
                                              child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Flexible(
                                                        flex: 0,
                                                        child: riw
                                                            .RecipeStepImagePicker()),
                                                    Flexible(
                                                        flex: 2,
                                                        child: riw
                                                            .RecipeStepDescriptionInput()),
                                                    Flexible(
                                                        flex: 0,
                                                        child: riw
                                                            .RecipeStepAddButton())
                                                  ])),
                                      readonly
                                          ? const riw.ReadonlyRecipeStepList()
                                          : const riw.RecipeStepList()
                                    ],
                                  ),
                                  Container(
                                      child: readonly
                                          ? null
                                          : ExpansionTile(
                                              initiallyExpanded: true,
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .trailing,
                                              title: Text(
                                                'Extra Information',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onBackground),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                              children: const [
                                                SizedBox(
                                                    height:
                                                        RecipeInteractionPageConstants
                                                            .sizedBoxHeight,
                                                    child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Flexible(
                                                              child: riw
                                                                  .CookingTimeInput()),
                                                          Flexible(
                                                              child: riw
                                                                  .KilocaloriesInput()),
                                                        ])),
                                                SizedBox(
                                                    height:
                                                        RecipeInteractionPageConstants
                                                            .sizedBoxHeight,
                                                    child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Flexible(
                                                              child: riw
                                                                  .ServingQuantityInput()),
                                                          Flexible(
                                                              child: riw
                                                                  .ServingMeasurementInput()),
                                                        ])),
                                                SizedBox(
                                                  height:
                                                      RecipeInteractionPageConstants
                                                          .sizedBoxHeight,
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Flexible(
                                                          child: riw
                                                              .ServingNumberInput()),
                                                      Spacer()
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )),
                                ],
                              ))));
            }));
  }
}
