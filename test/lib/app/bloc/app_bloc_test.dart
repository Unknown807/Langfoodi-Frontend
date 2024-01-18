import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_social_media/app/app.dart';
import '../../../../test_utilities/mocks/generic_mocks.dart';

void main() {
  late AuthenticationRepositoryMock authRepoMock;
  late LocalStoreMock localStoreMock;

  setUp(() {
    authRepoMock = AuthenticationRepositoryMock();
    localStoreMock = LocalStoreMock();
  });

  group("_changeAppTheme method tests", () {
    blocTest("new theme is set and emitted",
      build: () => AppBloc(localStoreMock, authRepoMock),
      act: (bloc) => bloc.add(const ChangeAppTheme(ThemeMode.dark)),
      expect: () => [
        const AppState(themeMode: ThemeMode.dark)
      ],
      verify: (_) {
        verify(() => localStoreMock.setKey("currentTheme", "dark")).called(1);
      }
    );
  });

  group("_initState method tests", () {
    blocTest("isAuthenticated is true and theme is light mode",
      build: () {
        when(() => authRepoMock.isAuthenticated()).thenAnswer((invocation) => Future.value(true));
        when(() => localStoreMock.getKey("currentTheme")).thenAnswer((invocation) => Future.value(null));
        return AppBloc(localStoreMock, authRepoMock);
      },
      act: (bloc) => bloc.add(const InitState()),
      expect: () => [
        const AppState(status: AppStatus.authenticated, themeMode: ThemeMode.light)
      ]
    );

    blocTest("isAuthenticated is false and theme is dark mode",
      build: () {
        when(() => authRepoMock.isAuthenticated()).thenAnswer((invocation) => Future.value(false));
        when(() => localStoreMock.getKey("currentTheme")).thenAnswer((invocation) => Future.value("dark"));
        return AppBloc(localStoreMock, authRepoMock);
      },
      act: (bloc) => bloc.add(const InitState()),
      expect: () => [
        const AppState(status: AppStatus.unauthenticated, themeMode: ThemeMode.dark)
      ]
    );
  });
}