import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_social_media/forms/widgets/form_widgets.dart';
import 'package:recipe_social_media/pages/recipes/recipe_interaction/bloc/recipe_interaction_bloc.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/navigation/navigation_repo.dart';
import 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';
import 'package:recipe_social_media/widgets/custom_alert_dialog.dart';
import 'package:recipe_social_media/widgets/custom_expansion_tile.dart';

class RecipeInteractionPage extends StatelessWidget {
  RecipeInteractionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (_) => RecipeRepository(),
        child: BlocProvider<RecipeInteractionBloc>(
            create: (recipeRepoContext) => RecipeInteractionBloc(
                context.read<AuthenticationRepository>(), recipeRepoContext.read<RecipeRepository>()),
            child: Scaffold(
                appBar: AppBar(
                  title: FormInput(
                      hint: "Recipe Name Here", textAlign: TextAlign.center, fontSize: 20, eventFunc: (val) {}),
                  backgroundColor: Colors.white,
                  elevation: 0.5,
                  leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_circle_left_outlined,
                      color: Colors.indigoAccent,
                      size: 30,
                    ),
                    onPressed: () => context.read<NavigationRepository>().goTo(context, "home", RouteType.backLink),
                  ),
                  actions: <Widget>[
                    IconButton(
                      padding: const EdgeInsets.only(right: 20),
                      icon: const Icon(
                        Icons.check_circle_outline,
                        color: Colors.lightGreenAccent,
                        size: 30,
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.white,
                body: SingleChildScrollView(
                    reverse: true,
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, MediaQuery.of(context).viewInsets.bottom),
                        child: Column(
                          children: <Widget>[
                            Image.network(
                                "https://bakingmischief.com/wp-content/uploads/2020/08/small-banana-cake-image-square-4-200x200.jpg"),
                            Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: FormInput(
                                    hint: "Recipe Description Here",
                                    boxDecorationType: FormInputBoxDecorationType.textArea,
                                    fontSize: 14,
                                    maxLines: 6,
                                    eventFunc: (val) {})),
                            Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: FormInput(
                                    hint: "Type Tags Here",
                                    boxDecorationType: FormInputBoxDecorationType.underlined,
                                    fontSize: 14,
                                    maxLines: 1,
                                    eventFunc: (val) {})),
                            CustomExpansionTile(
                              title: const Text(
                                'Ingredients',
                                style: TextStyle(color: Colors.black),
                              ),
                              children: [
                                Container(
                                    height: 65,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                            flex: 2,
                                            child: BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
                                                buildWhen: (p, c) => p.ingredientName != c.ingredientName,
                                                builder: (context, state) {
                                                  return FormInput(
                                                      textController: state.ingredientNameTextController,
                                                      innerPadding: const EdgeInsets.only(left: 5),
                                                      outerPadding:
                                                          const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                      hint: "Flour",
                                                      boxDecorationType: state.ingredientNameValid
                                                          ? FormInputBoxDecorationType.textArea
                                                          : FormInputBoxDecorationType.error,
                                                      fontSize: 14,
                                                      maxLines: 1,
                                                      onSubmittedEventFunc: (value) {
                                                        context
                                                            .read<RecipeInteractionBloc>()
                                                            .add(AddNewIngredientFromName(value));
                                                      },
                                                      eventFunc: (value) {
                                                        context
                                                            .read<RecipeInteractionBloc>()
                                                            .add(IngredientNameChanged(value));
                                                      });
                                                })),
                                        Flexible(
                                            flex: 1,
                                            child: BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
                                                buildWhen: (p, c) => p.ingredientQuantity != c.ingredientQuantity,
                                                builder: (context, state) {
                                                  return FormInput(
                                                      textController: state.ingredientQuantityTextController,
                                                      innerPadding: const EdgeInsets.only(left: 5),
                                                      outerPadding: const EdgeInsets.symmetric(vertical: 5),
                                                      hint: "1",
                                                      boxDecorationType: state.ingredientQuantityValid
                                                          ? FormInputBoxDecorationType.textArea
                                                          : FormInputBoxDecorationType.error,
                                                      fontSize: 14,
                                                      maxLines: 1,
                                                      onSubmittedEventFunc: (value) {
                                                        context
                                                            .read<RecipeInteractionBloc>()
                                                            .add(AddNewIngredientFromQuantity(value));
                                                      },
                                                      eventFunc: (value) {
                                                        context
                                                            .read<RecipeInteractionBloc>()
                                                            .add(IngredientQuantityChanged(value));
                                                      });
                                                })),
                                        Flexible(
                                            flex: 2,
                                            child: BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
                                                buildWhen: (p, c) => p.ingredientMeasurement != c.ingredientMeasurement,
                                                builder: (context, state) {
                                                  return FormInput(
                                                      textController: state.ingredientMeasurementTextController,
                                                      innerPadding: const EdgeInsets.only(left: 5),
                                                      outerPadding:
                                                          const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                      hint: "kg",
                                                      boxDecorationType: state.ingredientMeasurementValid
                                                          ? FormInputBoxDecorationType.textArea
                                                          : FormInputBoxDecorationType.error,
                                                      fontSize: 14,
                                                      maxLines: 1,
                                                      onSubmittedEventFunc: (value) {
                                                        context
                                                            .read<RecipeInteractionBloc>()
                                                            .add(AddNewIngredientFromMeasurement(value));
                                                      },
                                                      eventFunc: (value) {
                                                        context
                                                            .read<RecipeInteractionBloc>()
                                                            .add(IngredientMeasurementChanged(value));
                                                      });
                                                }))
                                      ],
                                    )),
                                BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
                                  buildWhen: (p, c) => p.ingredientList.length != c.ingredientList.length,
                                  builder: (context, state) {
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: state.ingredientList.length,
                                      itemBuilder: (context, index) {
                                        final ing = state.ingredientList[index];
                                        return Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Row(
                                          children: [
                                            Expanded(child: Text(
                                              "${ing.name}, ${ing.quantity.toStringAsFixed(ing.quantity.truncateToDouble() == ing.quantity ? 0 : 3)} ${ing.unitOfMeasurement}",
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400
                                              ),
                                            )),
                                            IconButton(
                                              splashRadius: 20,
                                              onPressed: () => showDialog(
                                                  context: context,
                                                  builder: (_) => BlocProvider<RecipeInteractionBloc>.value(
                                                    value: BlocProvider.of<RecipeInteractionBloc>(context),
                                                    child: CustomAlertDialog(
                                                      title: Text("Remove Ingredient"),
                                                      content: Text("Are you sure you want to remove ${ing.name}"),
                                                      rightButtonText: "Remove",
                                                      rightButtonCallback: () => context.read<RecipeInteractionBloc>().add(RemoveIngredient(index)),
                                                    )
                                                  )
                                              ),
                                              icon: const Icon(Icons.delete, color: Colors.redAccent)
                                            )
                                          ],
                                        ));
                                      },
                                    );
                                  },
                                )
                              ],
                            ),
                            CustomExpansionTile(
                              title: const Text(
                                'Recipe Steps',
                                style: TextStyle(color: Colors.black),
                              ),
                              children: [Text("child here")],
                            ),
                            CustomExpansionTile(
                              title: const Text(
                                'Nutrition',
                                style: TextStyle(color: Colors.black),
                              ),
                              children: [Text("child here")],
                            ),
                          ],
                        ))))));
  }
}
