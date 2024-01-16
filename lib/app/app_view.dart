part of 'app.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.authRepo,
    required this.navigationRepo,
    required this.imageRepo,
    required this.recipeRepo,
    required this.imageTransformationBuilder,
    required this.imageBuilder,
    required this.networkManager,
    required this.localStore,
  });

  // Repositories
  final AuthenticationRepository authRepo;
  final NavigationRepository navigationRepo;
  final ImageRepository imageRepo;
  final RecipeRepository recipeRepo;

  // Utilities
  final ImageTransformationBuilder imageTransformationBuilder;
  final ImageBuilder imageBuilder;
  final NetworkManager networkManager;
  final LocalStore localStore;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => authRepo),
        RepositoryProvider(create: (_) => navigationRepo),
        RepositoryProvider(create: (_) => imageRepo),
        RepositoryProvider(create: (_) => recipeRepo),
        RepositoryProvider(create: (_) => imageTransformationBuilder),
        RepositoryProvider(create: (_) => imageBuilder),
        RepositoryProvider(create: (_) => networkManager),
        RepositoryProvider(create: (_) => localStore),
      ],
      child: BlocProvider(
        create: (_) => AppBloc(localStore, authRepo)..add(const InitState()),
        child: const _AppView()
      ));
  }
}

class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      buildWhen: (p, c) => p.themeMode != c.themeMode,
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Recipe Social Media',
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            colorScheme: const ColorScheme(
              brightness: Brightness.light,
              primary: Colors.green,
              onPrimary: Colors.white,
              secondary: Colors.orange,
              tertiary: Colors.blueAccent,
              onTertiary: Colors.white,
              onSecondary: Colors.white,
              error: Colors.redAccent,
              onError: Colors.white,
              background: Colors.white,
              onBackground: Colors.black,
              surface: Colors.white,
              onSurface: Colors.black
            ),
            textTheme: const TextTheme(
              displayLarge: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)
            ),
          ),
          themeMode: state.themeMode,
          routes: {
            "/splash": (context) => const SplashPage(),
            "/home": (context) => const HomePage(),
            "/login": (context) => const LoginPage(),
            "/register": (context) => const RegisterPage(),
            "/recipe-view": (context) => const RecipeViewPage(),
            "/recipe-interaction": (context) => const RecipeInteractionPage(),
            "/profile-settings": (context) => const ProfileSettingsPage(),
            "/cloudinary-image-view": (context) => const CloudinaryImageViewPage()
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
          ));
      });
  }
}
