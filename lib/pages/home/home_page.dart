import 'package:flutter/material.dart';
import 'package:recipe_social_media/pages/recipe_view/recipe_view_page.dart';

export 'home_page.dart';
part 'widgets/nav_bar_view.dart';
part 'widgets/top_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const NavBarView();
  }
}
