part of 'app.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthenticationRepository authRepo}): super(const AppState.loading()) {
    _authRepo = authRepo;
    _initializeState();
  }

  late final AuthenticationRepository _authRepo;

  Future _initializeState() async {
    final isAuthenticated = await _authRepo.isAuthenticated();
    if (isAuthenticated) {
      emit(const AppState.authenticated());
    } else {
      emit(const AppState.unauthenticated());
    }
  }
}
