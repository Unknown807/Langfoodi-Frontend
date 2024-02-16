part of 'app.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.authRepo,
    required this.navigationRepo,
    required this.imageRepo,
    required this.recipeRepo,
    required this.conversationRepo,
    required this.messageRepo,
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
  final ConversationRepository conversationRepo;
  final MessageRepository messageRepo;

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
        RepositoryProvider(create: (_) => conversationRepo),
        RepositoryProvider(create: (_) => messageRepo),
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
          title: 'Langfoodi',
          theme: ThemeData(
            scaffoldBackgroundColor: const Color.fromRGBO(254, 254, 254, 1),
            primaryColor: const Color.fromRGBO(49, 183, 63, 1),
            colorScheme: ColorScheme(
              brightness: Brightness.light,
              primary: Colors.green.shade400,
              onPrimary: Colors.white,
              secondary: Colors.orange,
              tertiary: Colors.blueAccent,
              onTertiary: Colors.white,
              onSecondary: Colors.white,
              inversePrimary: Colors.redAccent,
              error: Colors.red,
              onError: Colors.white,
              background: const Color.fromRGBO(242, 242, 242, 1),
              onBackground: Colors.black,
              surface: Colors.white,
              onSurface: Colors.black,
              shadow: Colors.green.withAlpha(50)
            ),
            dividerColor: Colors.transparent,
            expansionTileTheme: const ExpansionTileThemeData(
              backgroundColor: Colors.transparent,
              collapsedBackgroundColor: Colors.transparent,
              iconColor: Colors.orange,
              collapsedIconColor: Colors.blueAccent,
            ),
            hintColor: Colors.grey,
            textTheme: const TextTheme(
              displayLarge: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)
            ),
          ),
          darkTheme: ThemeData(
            scaffoldBackgroundColor: const Color.fromRGBO(37, 38, 39, 1),
            primaryColor: const Color.fromRGBO(49, 183, 63, 1),
            colorScheme: ColorScheme(
              brightness: Brightness.dark,
              primary: Colors.green.shade400,
              onPrimary: Colors.white,
              secondary: Colors.orange,
              onSecondary: Colors.white,
              tertiary: Colors.blueAccent,
              onTertiary: Colors.white,
              inversePrimary: Colors.redAccent,
              error: Colors.red,
              onError: Colors.white,
              background: const Color.fromRGBO(70, 75, 78, 1),
              onBackground: Colors.white,
              surface: const Color.fromRGBO(70, 75, 78, 1),
              onSurface: Colors.white,
              shadow: Colors.green.withAlpha(50)
            ),
            dividerColor: Colors.transparent,
            expansionTileTheme: const ExpansionTileThemeData(
              backgroundColor: Colors.transparent,
              collapsedBackgroundColor: Colors.transparent,
              iconColor: Colors.orange,
              collapsedIconColor: Colors.blueAccent,
            ),
            hintColor: Colors.grey,
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
            "/cloudinary-image-view": (context) => const CloudinaryImageViewPage(),
            "/conversation-list": (context) => const ConversationListPage(),
            "/conversation": (context) => const ConversationPage()
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
