import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_social_media/entities/recipe/recipe_entities.dart';
import 'package:recipe_social_media/forms/widgets/form_widgets.dart';
import 'package:recipe_social_media/pages/recipes/recipe_interaction/bloc/recipe_interaction_bloc.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/navigation/args/recipe_interaction_page_arguments.dart';
import 'package:recipe_social_media/repositories/navigation/navigation_repo.dart';
import 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';
import 'package:recipe_social_media/widgets/custom_alert_dialog.dart';
import 'package:recipe_social_media/widgets/custom_expansion_tile.dart';

class RecipeInteractionPage extends StatelessWidget {
  const RecipeInteractionPage({super.key});

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments;
    if (args != null) {
      args = args as RecipeInteractionPageArguments;
      print(args.recipeId);
      print(args.readonly);
    }

    return RepositoryProvider(
        create: (_) => RecipeRepository(),
        child: BlocProvider<RecipeInteractionBloc>(
            create: (recipeRepoContext) => RecipeInteractionBloc(
                context.read<AuthenticationRepository>(), recipeRepoContext.read<RecipeRepository>()),
            child: Scaffold(
                appBar: AppBar(
                  title: FormInput(
                      hint: "Recipe Name Here",
                      innerPadding: EdgeInsets.zero,
                      outerPadding: const EdgeInsets.only(bottom: 5),
                      textAlign: TextAlign.center,
                      fontSize: 20,
                      eventFunc: (val) {}),
                  backgroundColor: Colors.white,
                  elevation: 0.5,
                  leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_circle_left_outlined,
                      color: Colors.indigoAccent,
                      size: 30,
                    ),
                    onPressed: () => context.read<NavigationRepository>().goTo(context, "home", routeType: RouteType.backLink),
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
                            Row(children: <Widget>[
                                Expanded(child:
                                  BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
                                  buildWhen: (p, c) => p.recipeThumbnailPath != c.recipeThumbnailPath,
                                  builder: (context, state) {
                                    return GestureDetector(
                                      onTap: () async {
                                        final selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                                        if (selectedImage != null && context.mounted) {
                                          context
                                              .read<RecipeInteractionBloc>()
                                              .add(RecipeThumbnailPicked(selectedImage.path));
                                        }
                                      } ,
                                      child: Padding(
                                          padding: const EdgeInsets.only(top: 5, right: 5),
                                          child: state.recipeThumbnailPath.isEmpty
                                              ? DottedBorder(
                                                  strokeWidth: 1.5,
                                                  color: Colors.blue,
                                                  borderType: BorderType.RRect,
                                                  radius: const Radius.circular(10),
                                                  padding: const EdgeInsets.all(25),
                                                  child: const Center(child: Icon(Icons.image, size: 70, color: Colors.blue,)))
                                              : AspectRatio(
                                                  aspectRatio: 4/3,
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(5),
                                                    child: Image.file(File(state.recipeThumbnailPath), fit: BoxFit.cover,))
                                              )),
                                    );
                                  }
                                ))
                            ]),
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
                              child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      flex: 6,
                                      child: FormInput(
                                        hint: "Type Tags Here",
                                        boxDecorationType: FormInputBoxDecorationType.underlined,
                                        fontSize: 14,
                                        maxLines: 1,
                                        eventFunc: (val) {})
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: IconButton(
                                        padding: const EdgeInsets.only(right: 1),
                                        splashRadius: 20,
                                        icon: const Icon(Icons.add_circle_outline_rounded, size: 25, color: Colors.blue,),
                                        onPressed: () {},
                                      ),
                                    ),
                                  ]
                              )
                          ),
                          //Chip(label: Text("ting"), deleteIcon: Icon(Icons.close, size: 15,), onDeleted: () {},),
                          CustomExpansionTile(
                            title: const Text(
                              'Ingredients',
                              style: TextStyle(color: Colors.black),
                            ),
                            children: [
                              SizedBox(
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
                                                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
                                                            title: const Text("Remove Ingredient"),
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
                            children: [
                              SizedBox(
                                  height: 100,
                                  child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          flex: 2,
                                          child: BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
                                            buildWhen: (p, c) => p.recipeStepDescription != c.recipeStepDescription,
                                            builder: (context, state) {
                                              return FormInput(
                                                textController: state.recipeStepDescriptionTextController,
                                                innerPadding: const EdgeInsets.only(left: 5),
                                                outerPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                hint: "Write step here and enter to submit",
                                                boxDecorationType: state.recipeStepDescriptionValid
                                                    ? FormInputBoxDecorationType.textArea
                                                    : FormInputBoxDecorationType.error,
                                                fontSize: 14,
                                                maxLines: 6,
                                                onSubmittedEventFunc: (value) {
                                                  context
                                                    .read<RecipeInteractionBloc>()
                                                    .add(AddNewRecipeStepFromDescription(value));
                                                },
                                                eventFunc: (value) {
                                                  context
                                                    .read<RecipeInteractionBloc>()
                                                    .add(RecipeStepDescriptionChanged(value));
                                                },
                                              );
                                            }
                                          ),
                                        ),
                                        Flexible(
                                            flex: 0,
                                            child: BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
                                              buildWhen: (p, c) => p.recipeStepImagePath != c.recipeStepImagePath,
                                              builder: (context, state) {
                                                return GestureDetector(
                                                    onTap: () async {
                                                      final selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                                                      if (selectedImage != null && context.mounted) {
                                                        context
                                                          .read<RecipeInteractionBloc>()
                                                          .add(RecipeStepImagePicked(selectedImage.path));
                                                      }
                                                    },
                                                    child: Padding(
                                                        padding: const EdgeInsets.only(top: 5, right: 5, bottom: 5),
                                                        child: state.recipeStepImagePath.isEmpty
                                                            ? DottedBorder(
                                                                strokeWidth: 1.5,
                                                                color: Colors.blue,
                                                                borderType: BorderType.RRect,
                                                                radius: const Radius.circular(10),
                                                                padding: const EdgeInsets.all(25),
                                                                child: const Center(child: Icon(Icons.image, size: 40, color: Colors.blue,)))
                                                            : AspectRatio(
                                                                aspectRatio: 1/1,
                                                                child: ClipRRect(
                                                                  borderRadius: BorderRadius.circular(5),
                                                                  child: Image.file(File(state.recipeStepImagePath), fit: BoxFit.cover,))
                                                        ))
                                                );
                                              }
                                            )
                                        )
                                      ]
                                  )
                              ),
                              BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
                                builder: (context, state) {
                                  return ReorderableListView.builder(
                                    shrinkWrap: true,
                                    buildDefaultDragHandles: false,
                                    itemCount: state.recipeStepList.length,
                                    onReorder: (int oldIndex, int newIndex) {
                                      context
                                        .read<RecipeInteractionBloc>()
                                        .add(ReorderRecipeStepList(oldIndex, newIndex));
                                    },
                                    itemBuilder: (context, index) {
                                      final step = state.recipeStepList[index];
                                      return ReorderableDragStartListener(
                                          index: index,
                                          key: ValueKey(step),
                                          child: Padding(
                                          padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                                          child: Column(
                                            children: <Widget>[
                                                AspectRatio(
                                                aspectRatio: 3/1,
                                                child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(5),
                                                    child: Image.file(File(step.imageUrl!), fit: BoxFit.cover,))),
                                                Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                      child: Padding(padding: const EdgeInsets.only(top:5, bottom: 5),
                                                        child: Text(
                                                          "${index+1}. ${step.text}",
                                                          style: const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w400
                                                          ),
                                                        )
                                                      )
                                                  ),
                                                  Column(
                                                    children: <Widget>[
                                                      IconButton(
                                                        splashRadius: 20,
                                                        onPressed: () => showDialog(
                                                            context: context,
                                                            builder: (_) => BlocProvider<RecipeInteractionBloc>.value(
                                                                value: BlocProvider.of<RecipeInteractionBloc>(context),
                                                                child: CustomAlertDialog(
                                                                  title: const Text("Remove Step"),
                                                                  content: Text("Are you sure you want to remove step ${index+1}?"),
                                                                  rightButtonText: "Remove",
                                                                  rightButtonCallback: () => context.read<RecipeInteractionBloc>().add(RemoveRecipeStep(index)),
                                                                )
                                                            )
                                                        ),
                                                        icon: const Icon(Icons.delete, color: Colors.redAccent)
                                                      ),
                                                      IconButton(
                                                        splashRadius: 20,
                                                        onPressed: () => Clipboard.setData(ClipboardData(text: step.text)).then((_) {
                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                              SnackBar(
                                                                content: Text("Step ${index+1} copied to clipboard"),
                                                                backgroundColor: Colors.lightGreen,
                                                              ));
                                                        }),
                                                        icon: const Icon(Icons.copy, color: Colors.black54)
                                                      )
                                                    ],
                                                  )
                                                ],
                                              )
                                      ])));
                                    },
                                  );
                                },
                              )
                            ],
                          ),
                          CustomExpansionTile(
                            title: const Text(
                              'Extra Information',
                              style: TextStyle(color: Colors.black),
                            ),
                            children: [
                              SizedBox(
                                  height: 65,
                                  child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
                                              buildWhen: (p, c) => p.servingNumber != c.servingNumber,
                                              builder: (context, state) {
                                                return FormInput(
                                                  textController: state.servingNumberTextController,
                                                  keyboardType: TextInputType.number,
                                                  innerPadding: const EdgeInsets.only(left: 5),
                                                  outerPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                  hint: 'Number Of Servings',
                                                  boxDecorationType: state.servingNumberValid
                                                      ? FormInputBoxDecorationType.textArea
                                                      : FormInputBoxDecorationType.error,
                                                  fontSize: 14,
                                                  eventFunc: (value) {
                                                    context
                                                        .read<RecipeInteractionBloc>()
                                                        .add(ServingNumberChanged(value));
                                                  },
                                                );
                                              },
                                          )
                                        ),
                                        Flexible(
                                          child: BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
                                            buildWhen: (p, c) => p.servingSize != c.servingSize,
                                            builder: (context, state) {
                                              return FormInput(
                                                textController: state.servingSizeTextController,
                                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                                innerPadding: const EdgeInsets.only(left: 5),
                                                outerPadding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                                                hint: 'Serving Size',
                                                boxDecorationType: state.servingSizeValid
                                                    ? FormInputBoxDecorationType.textArea
                                                    : FormInputBoxDecorationType.error,
                                                fontSize: 14,
                                                eventFunc: (value) {
                                                  context
                                                    .read<RecipeInteractionBloc>()
                                                    .add(ServingSizeChanged(value));
                                                },
                                              );
                                            }
                                          )
                                        ),
                                      ]
                                  )
                              ),
                              SizedBox(
                                  height: 65,
                                  child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
                                            buildWhen: (p, c) => p.cookingTime != c.cookingTime,
                                            builder: (context, state) {
                                              return FormInput(
                                                textController: state.cookingTimeTextController,
                                                innerPadding: const EdgeInsets.only(left: 5),
                                                outerPadding: const EdgeInsets.symmetric(horizontal: 10),
                                                hint: 'Cooking Time',
                                                boxDecorationType: state.cookingTimeValid
                                                    ? FormInputBoxDecorationType.textArea
                                                    : FormInputBoxDecorationType.error,
                                                fontSize: 14,
                                                eventFunc: (value) {
                                                  context
                                                    .read<RecipeInteractionBloc>()
                                                    .add(CookingTimeChanged(value));
                                                },
                                              );
                                            }
                                          )
                                        ),
                                        Flexible(
                                          child: BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
                                            buildWhen: (p, c) => p.kilocalories != c.kilocalories,
                                            builder: (context, state) {
                                              return FormInput(
                                                textController: state.kilocaloriesTextController,
                                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                                innerPadding: const EdgeInsets.only(left: 5),
                                                outerPadding: const EdgeInsets.fromLTRB(0, 0, 10, 5),
                                                hint: 'Kilocalories',
                                                boxDecorationType: state.kilocaloriesValid
                                                    ? FormInputBoxDecorationType.textArea
                                                    : FormInputBoxDecorationType.error,
                                                fontSize: 14,
                                                eventFunc: (value) {
                                                  context
                                                    .read<RecipeInteractionBloc>()
                                                    .add(KilocaloriesChanged(value));
                                                },
                                              );
                                            }
                                          ),
                                        ),
                                      ]
                                  )
                              ),
                            ],
                          ),
                        ],
                      ))))));
  }
}
