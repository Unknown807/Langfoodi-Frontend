part of 'package:recipe_social_media/app/app.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required AuthenticationRepository authRepo,
    required LocalStore localStore,
  }): super(const AppState(status: AppStatus.loading))
  {
    on<InitState>(_initState);
    on<ChangeAppTheme>(_changeAppTheme);
  }

  late final LocalStore localStore;
  late final AuthenticationRepository authRepo;

  void _initState(InitState event, Emitter<AppState> emit) async {
    final isAuthenticated = await authRepo.isAuthenticated();

    if (isAuthenticated) {
      emit(state.copyWith(status: ));
    } else {
      emit(const AppState.unauthenticated());
    }
  }

  void _changeAppTheme(ChangeAppTheme event, Emitter<AppState> emit) async {
    emit(state.copyWith(themeMode: event.themeMode));
  }
}
