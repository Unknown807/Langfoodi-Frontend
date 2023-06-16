import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_social_media/pages/home/home_page.dart';
import 'package:recipe_social_media/pages/login/login_page.dart';
import 'package:recipe_social_media/pages/splash/splash_page.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'bloc/app.dart';

class App extends StatelessWidget {
  const App({super.key, required AuthenticationRepository authRepo})
      : _authRepo = authRepo;

  final AuthenticationRepository _authRepo;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepo,
      child: BlocProvider(
        create: (_) => AppBloc(authRepo: _authRepo),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe Social Media',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
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
