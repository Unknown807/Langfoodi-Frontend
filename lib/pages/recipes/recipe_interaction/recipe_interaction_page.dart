import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_social_media/forms/widgets/form_widgets.dart';
import 'package:recipe_social_media/pages/recipes/recipe_interaction/bloc/recipe_interaction_bloc.dart';
import 'package:recipe_social_media/pages/recipes/recipe_interaction/widgets/recipe_interaction_widgets.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/image/image_repo.dart';
import 'package:recipe_social_media/repositories/navigation/args/recipe_interaction_page_arguments.dart';
import 'package:recipe_social_media/repositories/navigation/navigation_repo.dart';
import 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';
import 'package:recipe_social_media/widgets/custom_alert_dialog.dart';
import 'package:recipe_social_media/widgets/custom_expansion_tile.dart';

class RecipeInteractionPage extends StatelessWidget {
  const RecipeInteractionPage({super.key});

  static const double inputFormFontSize = 14;

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments;
    if (args != null) {
      args = args as RecipeInteractionPageArguments;
      print(args.recipeId);
      print(args.readonly);
    }

    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (_) => ImageRepository()),
          RepositoryProvider(create: (_) => RecipeRepository()),
        ],
        child: BlocProvider<RecipeInteractionBloc>(
            create: (recipeInteractContext) => RecipeInteractionBloc(
              context.read<AuthenticationRepository>(),
              recipeInteractContext.read<RecipeRepository>(),
              recipeInteractContext.read<ImageRepository>()),
            child: BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
              buildWhen: (p, c) => p.formStatus != c.formStatus,
              builder: (context, state) {
                return state.formStatus.isInProgress
                    ? const Scaffold(body: Center(child: CircularProgressIndicator()))
                    : Scaffold(
                        appBar: AppBar(
                          title: const RITitleField(),
                          backgroundColor: Colors.white,
                          elevation: 0.5,
                          leading: const RIBackButton(),
                          actions: const <Widget>[
                            RISubmitButton()
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
                                    const Row(children: <Widget>[
                                        Expanded(child: RIThumbnailPicker())
                                    ]),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: RIDescriptionField()
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget> [
                                        RITagField(),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10),
                                          child: RITagList()
                                        )
                                      ]
                                    )
                                  ),
                                  CustomExpansionTile(
                                    title: const Text(
                                      'Ingredients',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    children: const [
                                      SizedBox(
                                          height: 65,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                  flex: 2,
                                                  child: RIIngredientNameField()),
                                              Flexible(
                                                  flex: 1,
                                                  child: RIIngredientQuantityField()),
                                              Flexible(
                                                  flex: 2,
                                                  child: RIIngredientMeasurementField())
                                            ],
                                          )),
                                      RIIngredientList()
                                    ],
                                  ),
                                  CustomExpansionTile(
                                    title: const Text(
                                      'Recipe Steps',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    children: const [
                                      SizedBox(
                                          height: 100,
                                          child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Flexible(
                                                  flex: 2,
                                                  child: RIRecipeStepDescriptionField(),
                                                ),
                                                Flexible(
                                                    flex: 0,
                                                    child: RIRecipeStepImagePicker()
                                                )
                                              ]
                                          )
                                      ),
                                      RecipeStepList()
                                    ],
                                  ),
                                  CustomExpansionTile(
                                    title: const Text(
                                      'Extra Information',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    children: const [
                                      SizedBox(
                                          height: 65,
                                          child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Flexible(
                                                  child: ServingNumberInput()
                                                ),
                                                Flexible(
                                                  child: RIServingSizeField()
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
                                                  child: CookingTimeInput()
                                                ),
                                                Flexible(
                                                  child: KilocaloriesInput(),
                                                ),
                                              ]
                                          )
                                      ),
                                    ],
                                  ),
                                ],
                              ))));
            })));
  }
}

class RIServingSizeField extends StatelessWidget {
  const RIServingSizeField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
        buildWhen: (p, c) => p.servingSize != c.servingSize
            || p.servingSizeValid != c.servingSizeValid,
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
            fontSize: RecipeInteractionPage.inputFormFontSize,
            eventFunc: (value) {
              context
                  .read<RecipeInteractionBloc>()
                  .add(ServingSizeChanged(value));
            },
          );
        }
    );
  }
}

class RIRecipeStepImagePicker extends StatelessWidget {
  const RIRecipeStepImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
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
    );
  }
}

class RIRecipeStepDescriptionField extends StatelessWidget {
  const RIRecipeStepDescriptionField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
        buildWhen: (p, c) => p.recipeStepDescription != c.recipeStepDescription
            || p.recipeDescriptionValid != c.recipeDescriptionValid,
        builder: (context, state) {
          return FormInput(
            textController: state.recipeStepDescriptionTextController,
            innerPadding: const EdgeInsets.only(left: 5),
            outerPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            hint: "Write step here and enter to submit",
            boxDecorationType: state.recipeStepDescriptionValid
                ? FormInputBoxDecorationType.textArea
                : FormInputBoxDecorationType.error,
            fontSize: RecipeInteractionPage.inputFormFontSize,
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
    );
  }
}

class RIIngredientList extends StatelessWidget {
  const RIIngredientList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
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
    );
  }
}

class RIIngredientMeasurementField extends StatelessWidget {
  const RIIngredientMeasurementField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
        buildWhen: (p, c) => p.ingredientMeasurement != c.ingredientMeasurement
            || p.ingredientMeasurementValid != c.ingredientMeasurementValid,
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
              fontSize: RecipeInteractionPage.inputFormFontSize,
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
        });
  }
}

class RIIngredientQuantityField extends StatelessWidget {
  const RIIngredientQuantityField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
        buildWhen: (p, c) => p.ingredientQuantity != c.ingredientQuantity
            || p.ingredientQuantityValid != c.ingredientQuantityValid,
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
              fontSize: RecipeInteractionPage.inputFormFontSize,
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
        });
  }
}

class RIIngredientNameField extends StatelessWidget {
  const RIIngredientNameField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
        buildWhen: (p, c) => p.ingredientName != c.ingredientName
            || p.ingredientNameValid != c.ingredientNameValid,
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
              fontSize: RecipeInteractionPage.inputFormFontSize,
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
        });
  }
}

class RISubmitButton extends StatelessWidget {
  const RISubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
        builder: (context, state) {
          return IconButton(
            padding: const EdgeInsets.only(right: 20),
            icon: const Icon(
              Icons.check_circle_outline,
              color: Colors.lightGreenAccent,
              size: 30,
            ),
            onPressed: () => showDialog(
                context: context,
                builder: (_) => BlocProvider<RecipeInteractionBloc>.value(
                    value: BlocProvider.of<RecipeInteractionBloc>(context),
                    child: CustomAlertDialog(
                      title: const Text("Create Recipe"),
                      content: const Text("Ready to create your recipe? (may take a second)"),
                      rightButtonText: "Create",
                      rightButtonCallback: () => context.read<RecipeInteractionBloc>().add(const RecipeFormSubmission()),
                    )
                )
            ),
          );
        }
    );
  }
}

class RIBackButton extends StatelessWidget {
  const RIBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_circle_left_outlined,
        color: Colors.indigoAccent,
        size: 30,
      ),
      onPressed: () => context.read<NavigationRepository>().goTo(context, "home", routeType: RouteType.backLink),
    );
  }
}

class RITitleField extends StatelessWidget {
  const RITitleField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
        buildWhen: (p, c) => p.recipeTitle != c.recipeTitle
            || p.recipeTitleValid != c.recipeTitleValid,
        builder: (context, state) {
          return FormInput(
              textController: state.recipeTitleTextController,
              hint: "Recipe Name Here",
              boxDecorationType: state.recipeTitleValid
                  ? FormInputBoxDecorationType.minimal
                  : FormInputBoxDecorationType.error,
              innerPadding: EdgeInsets.zero,
              outerPadding: const EdgeInsets.only(bottom: 5),
              textAlign: TextAlign.center,
              fontSize: 20,
              eventFunc: (value) {
                context
                    .read<RecipeInteractionBloc>()
                    .add(RecipeTitleChanged(value));
              }
          );
        });
  }
}

class RIThumbnailPicker extends StatelessWidget {
  const RIThumbnailPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
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
    );
  }
}

class RIDescriptionField extends StatelessWidget {
  const RIDescriptionField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
        buildWhen: (p, c) => p.recipeDescription != c.recipeDescription
            || p.recipeDescriptionValid != c.recipeDescriptionValid,
        builder: (context, state) {
          return FormInput(
              textController: state.recipeDescriptionTextController,
              hint: "Recipe Description Here",
              boxDecorationType: state.recipeDescriptionValid
                  ? FormInputBoxDecorationType.textArea
                  : FormInputBoxDecorationType.error,
              fontSize: RecipeInteractionPage.inputFormFontSize,
              maxLines: 6,
              eventFunc: (value) {
                context
                    .read<RecipeInteractionBloc>()
                    .add(RecipeDescriptionChanged(value));
              }
          );
        }
    );
  }
}

class RITagField extends StatelessWidget {
  const RITagField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
        builder: (context, state) {
          return Row(
              children: <Widget>[
                Flexible(
                    flex: 6,
                    child: FormInput(
                      textController: state.recipeTagTextController,
                      hint: "Type Tags Here",
                      boxDecorationType: state.recipeTagValid
                          ? FormInputBoxDecorationType.underlined
                          : FormInputBoxDecorationType.underlinedError,
                      fontSize: RecipeInteractionPage.inputFormFontSize,
                      maxLines: 1,
                      eventFunc: (value) {
                        context
                            .read<RecipeInteractionBloc>()
                            .add(RecipeTagChanged(value));
                      },
                      onSubmittedEventFunc: (value) {
                        context
                            .read<RecipeInteractionBloc>()
                            .add(AddNewRecipeTagFromField(value));
                      },
                    )
                ),
                Flexible(
                  flex: 1,
                  child: IconButton(
                    padding: const EdgeInsets.only(right: 1),
                    splashRadius: 20,
                    icon: const Icon(Icons.add_circle_outline_rounded, size: 25, color: Colors.blue,),
                    onPressed: () {
                      context
                          .read<RecipeInteractionBloc>()
                          .add(const AddNewRecipeTagFromButton());
                    },
                  ),
                ),
              ]
          );
        }
    );
  }
}

class RITagList extends StatelessWidget {
  const RITagList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInteractionBloc, RecipeInteractionState>(
        buildWhen: (p, c) => p.recipeTagList.length != c.recipeTagList.length,
        builder: (context, state) {
          return Wrap(
              runSpacing: 5,
              spacing: 10,
              children:
              List.generate(
                  state.recipeTagList.length,
                      (index) {
                    final label = state.recipeTagList[index];
                    return Chip(
                      label: Text(label,
                          style: const TextStyle(color: Color.fromRGBO(98, 151, 246, 1))),
                      backgroundColor: const Color.fromRGBO(229, 239, 255, 1),
                      deleteButtonTooltipMessage: "",
                      deleteIcon: const Icon(Icons.close_rounded,
                          color: Color.fromRGBO(98, 151, 246, 1),
                          size: 17),
                      onDeleted: () {
                        context
                            .read<RecipeInteractionBloc>()
                            .add(RemoveRecipeTag(index));
                      },
                    );
                  }
              )
          );
        }
    );
  }
}
