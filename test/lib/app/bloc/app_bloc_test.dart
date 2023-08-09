import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_social_media/app/app.dart';
import '../../../../test_utilities/mocks/generic_mocks.dart';

void main() {
  late AuthenticationRepositoryMock authRepoMock;

  setUp(() {
    authRepoMock = AuthenticationRepositoryMock();
  });

  group("_initializeState method tests", () {
    blocTest("isAuthenticated is true",
      build: () {
        when(() => authRepoMock.isAuthenticated()).thenAnswer((invocation) => Future.value(true));
        return AppBloc(authRepo: authRepoMock);
      },
      expect: () => [const AppState.authenticated()]
    );

    blocTest("isAuthenticated is false",
      build: () {
        when(() => authRepoMock.isAuthenticated()).thenAnswer((invocation) => Future.value(false));
        return AppBloc(authRepo: authRepoMock);
      },
      expect: () => [const AppState.unauthenticated()]
    );
  });
}