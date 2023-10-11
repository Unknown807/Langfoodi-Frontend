part of '../app.dart';

enum AppStatus { loading, authenticated, unauthenticated }

final class AppState extends Equatable {
  const AppState._({required this.status});

  final AppStatus status;
  // TODO: could have a variable here for current theme

  const AppState.loading() : this._(status: AppStatus.loading);
  const AppState.authenticated() : this._(status: AppStatus.authenticated);
  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  @override
  List<Object> get props => [status];
}