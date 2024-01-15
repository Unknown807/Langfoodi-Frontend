part of 'package:recipe_social_media/app/app.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(this.localStore, this.authRepo): super(const AppState(status: AppStatus.loading))
  {
    on<InitState>(_initState);
    on<ChangeAppTheme>(_changeAppTheme);
  }

  final LocalStore localStore;
  final AuthenticationRepository authRepo;
  final themeKey = "currentTheme";

  void _initState(InitState event, Emitter<AppState> emit) async {
    final isAuthenticated = await authRepo.isAuthenticated();
    final status = isAuthenticated ? AppStatus.authenticated : AppStatus.unauthenticated;

    String currentTheme = await localStore.getKey(themeKey) ?? "light";
    ThemeMode themeMode = currentTheme == "light" ? ThemeMode.light : ThemeMode.dark;

    emit(state.copyWith(
      status: status,
      themeMode: themeMode
    ));
  }

  void _changeAppTheme(ChangeAppTheme event, Emitter<AppState> emit) async {
    String newTheme = event.themeMode == ThemeMode.light ? "light" : "dark";
    localStore.setKey(themeKey, newTheme);

    emit(state.copyWith(themeMode: event.themeMode));
  }
}
