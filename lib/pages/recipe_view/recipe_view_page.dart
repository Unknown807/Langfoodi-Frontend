import 'package:flutter/material.dart';
import 'package:recipe_social_media/utilities/utilities.dart';

class RecipeViewPage extends StatelessWidget implements PageLander {
  const RecipeViewPage({super.key});

  @override
  void onLanding() {
    print("Recipe page here");
  }

  @override
  Widget build(BuildContext context) {
    return const Text("recipe page here");
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