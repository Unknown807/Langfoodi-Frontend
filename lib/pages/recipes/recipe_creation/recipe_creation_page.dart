import 'package:flutter/material.dart';
import 'package:recipe_social_media/forms/widgets/form_widgets.dart';

class RecipeCreationPage extends StatelessWidget {
  const RecipeCreationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.arrow_circle_left_outlined,
                  color: Colors.indigoAccent,
                  size: 30,
                ),
                onPressed: () {},
              ),
              const Spacer(),
              IconButton(
                padding: const EdgeInsets.only(top: 5.0, right: 10.0),
                icon: const Icon(
                  Icons.check_circle_outline,
                  color: Colors.lightGreenAccent,
                  size: 30,
                ),
                onPressed: () {},
              )
            ],
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                FormInput(
                  hint: "Recipe Name Here",
                  useBorderStyle: true,
                  width: MediaQuery.of(context).size.width / 1.25,
                  textAlign: TextAlign.center,
                  fontSize: 20,
                  eventFunc: (val) {})
              ],
            )
          )
        ],
      ),
    );
  }
}
