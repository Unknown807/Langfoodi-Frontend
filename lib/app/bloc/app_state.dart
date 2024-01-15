part of 'package:recipe_social_media/app/app.dart';

enum AppStatus { loading, authenticated, unauthenticated }

final class AppState extends Equatable {
  const AppState({this.status = AppStatus.loading, this.themeMode = ThemeMode.light});
  const AppState._({required this.status, this.themeMode = ThemeMode.light});

  final AppStatus status;
  final ThemeMode themeMode;

  @override
  List<Object> get props => [status, themeMode];

  AppState copyWith({
    AppStatus? status,
    ThemeMode? themeMode
  }) {
    return AppState(
      status: status ?? this.status,
      themeMode: themeMode ?? this.themeMode
    );
  }
}