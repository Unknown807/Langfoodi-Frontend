import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_social_media/pages/recipe_view/bloc/recipe_view_page_bloc.dart';
import 'package:recipe_social_media/pages/recipe_view/recipe_view_page.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';
import 'package:recipe_social_media/utilities/utilities.dart';

export 'home_page.dart';
part 'widgets/nav_bar_view.dart';
part 'widgets/top_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (_) => RecipeRepository(),
        child: BlocProvider<RecipeViewPageBloc>(
            create: (recipeRepoContext) => RecipeViewPageBloc(
                context.read<AuthenticationRepository>(),
                recipeRepoContext.read<RecipeRepository>()),
            child: const NavBarView(widgetPages: [
              PlaceholderPage(),
              RecipeViewPage(),
              PlaceholderPage(),
              PlaceholderPage()
            ])));
  }
}
