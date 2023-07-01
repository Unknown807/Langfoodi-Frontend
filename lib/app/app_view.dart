import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_social_media/pages/home/home_page.dart';
import 'package:recipe_social_media/pages/login/login_page.dart';
import 'package:recipe_social_media/pages/register/register_page.dart';
import 'package:recipe_social_media/pages/splash/splash_page.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/navigation/navigation_repo.dart';
import 'bloc/app.dart';

class App extends StatelessWidget {
  const App({super.key, required this.authRepo, required this.navigationRepo});

  final AuthenticationRepository authRepo;
  final NavigationRepository navigationRepo;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (_) => authRepo),
          RepositoryProvider(create: (_) => navigationRepo),
        ],
        child: BlocProvider(
          create: (_) => AppBloc(authRepo: authRepo),
          child: const _AppView()
        )
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe Social Media',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      routes: {
        "/splash": (context) => const SplashPage(),
        "/home": (context) => const HomePage(),
        "/login": (context) => const LoginPage(),
        "/register": (context) => const RegisterPage()
      },
      home: BlocBuilder<AppBloc, AppState>(
        buildWhen: (p, c) => p.status != c.status,
        builder: (context, state) {
          switch (state.status) {
            case AppStatus.authenticated:
              return const HomePage();
            case AppStatus.unauthenticated:
              return const LoginPage();
            default:
              return const SplashPage();
          }
        },
      )
    );
  }
}
