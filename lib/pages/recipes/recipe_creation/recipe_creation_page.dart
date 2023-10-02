import 'package:flutter/material.dart';
import 'package:recipe_social_media/forms/widgets/form_widgets.dart';

class RecipeCreationPage extends StatelessWidget {
  const RecipeCreationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: FormInput(
              hint: "Recipe Name Here",
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
            onPressed: () {},
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
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                  children: <Widget>[
                    Image.network(
                        "https://bakingmischief.com/wp-content/uploads/2020/08/small-banana-cake-image-square-4-200x200.jpg"),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: FormInput(
                            hint: "Recipe Description Here",
                            boxDecorationType:
                                FormInputBoxDecorationType.fullBorder,
                            fontSize: 14,
                            maxLines: 6,
                            eventFunc: (val) {})),
                  ],
                ))));
  }
}
