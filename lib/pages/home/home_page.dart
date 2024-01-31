import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_social_media/pages/conversation_list/bloc/conversation_list_bloc.dart';
import 'package:recipe_social_media/pages/conversation_list/conversation_list_page.dart';
import 'package:recipe_social_media/pages/profile_settings/bloc/profile_settings_bloc.dart';
import 'package:recipe_social_media/pages/profile_settings/profile_settings_page.dart';
import 'package:recipe_social_media/pages/recipes/recipe_view/bloc/recipe_view_bloc.dart';
import 'package:recipe_social_media/pages/recipes/recipe_view/recipe_view_page.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/navigation/navigation_repo.dart';
import 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';
import 'package:recipe_social_media/utilities/utilities.dart';

export 'home_page.dart';
part 'widgets/nav_bar_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ConversationListBloc()),
        BlocProvider(create: (_) => ProfileSettingsBloc(
          context.read<AuthenticationRepository>()
        )),
        BlocProvider(create: (_) => RecipeViewBloc(
          context.read<AuthenticationRepository>(),
          context.read<NavigationRepository>(),
          context.read<RecipeRepository>(),
          context.read<NetworkManager>()),
        ),
      ],
      child: const NavBarView(
        widgetPages: [
          ConversationListPage(),
          RecipeViewPage(),
          ProfileSettingsPage()
        ],
        onLandOnce: [false, true, false]
      )
    );
  }
}
