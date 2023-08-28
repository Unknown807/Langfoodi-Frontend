part of 'app.dart';

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
  const _AppView();

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
        "/register": (context) => const RegisterPage(),
        "/recipe_view": (context) => RecipeViewPage()
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
