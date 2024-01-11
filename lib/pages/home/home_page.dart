import 'package:flutter/material.dart';
import 'package:recipe_social_media/pages/conversation_list_page/conversation_list_page.dart';
import 'package:recipe_social_media/pages/recipes/recipe_view/recipe_view_page.dart';
import 'package:recipe_social_media/utilities/utilities.dart';

export 'home_page.dart';
part 'widgets/nav_bar_view.dart';
part 'widgets/top_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const NavBarView(
      widgetPages: [
        ConversationListPage(),
        RecipeViewPage(),
        PlaceholderPage(),
        PlaceholderPage()
      ],
      onLandOnce: [false, true, false, false],
    );
  }
}
