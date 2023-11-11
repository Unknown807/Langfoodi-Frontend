import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_social_media/entities/recipe/recipe_entities.dart';
import 'package:recipe_social_media/entities/user/user.dart';
import 'package:recipe_social_media/pages/recipes/recipe_view/bloc/recipe_view_bloc.dart';
import 'package:recipe_social_media/widgets/shared_widgets.dart';
import '../../../../../../test_utilities/mocks/generic_mocks.dart';

void main() {
  late AuthenticationRepositoryMock authRepoMock;
  late RecipeRepositoryMock recipeRepoMock;

  setUp(() {
    authRepoMock = AuthenticationRepositoryMock();
    recipeRepoMock = RecipeRepositoryMock();
  });

  group("_changeRecipesToDisplay method tests", () {
    blocTest("list of scrollable recipes is emitted",
      build: () {
        final recipes = [
          Recipe("1", "title1", "desc1", "user1",
              const ["lbl"], const Duration(seconds: 500), 1000, 1,
              DateTime.now(), DateTime.now()),
          Recipe("2", "title2", "desc1", "user1",
              const ["lbl"], const Duration(seconds: 500), 1000, 1,
              DateTime.now(), DateTime.now()),
        ];
        final user = User("01", "testHandler", "user1", "mail@example.com", "Pass123!", DateTime.parse("2023-11-08"));

        when(() => authRepoMock.currentUser).thenAnswer((invocation) => Future.value(user));
        when(() => recipeRepoMock.getRecipesFromUserId(any())).thenAnswer((invocation) => Future.value(recipes));
        return RecipeViewBloc(authRepoMock, recipeRepoMock);
      },
      act: (bloc) => bloc.add(const ChangeRecipesToDisplay()),
      expect: () => [
        const RecipeViewState(recipesToDisplay: [
          ScrollItem("1", "https://daniscookings.com/wp-content/uploads/2021/03/Cinnamon-Roll-Cake-23.jpg", "title1"),
          ScrollItem("2", "https://daniscookings.com/wp-content/uploads/2021/03/Cinnamon-Roll-Cake-23.jpg", "title2")
        ])
      ]
    );
  });
}