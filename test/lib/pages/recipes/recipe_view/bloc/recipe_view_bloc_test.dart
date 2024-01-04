import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_social_media/entities/recipe/recipe_entities.dart';
import 'package:recipe_social_media/entities/user/user_entities.dart';
import 'package:recipe_social_media/pages/recipes/recipe_view/bloc/recipe_view_bloc.dart';
import 'package:recipe_social_media/repositories/navigation/args/recipe_interaction/recipe_interaction_page_arguments.dart';
import 'package:recipe_social_media/repositories/navigation/navigation_repo.dart';
import 'package:recipe_social_media/widgets/shared_widgets.dart';
import '../../../../../../test_utilities/mocks/generic_mocks.dart';

void main() {
  late NavigationRepositoryMock navigationRepositoryMock;
  late AuthenticationRepositoryMock authRepoMock;
  late RecipeRepositoryMock recipeRepoMock;

  setUp(() {
    navigationRepositoryMock = NavigationRepositoryMock();
    authRepoMock = AuthenticationRepositoryMock();
    recipeRepoMock = RecipeRepositoryMock();

    registerFallbackValue(BuildContextMock());
  });

  group("_goToInteractionPageAndExpectResult method tests", () {
    blocTest("successMessage is emitted",
      build: () {
        when(() => navigationRepositoryMock.goTo(
            any(), "/recipe-interaction",
            routeType: RouteType.expect, arguments: any(named: "arguments")))
        .thenAnswer((invocation) => Future.value(null));

        return RecipeViewBloc(authRepoMock, navigationRepositoryMock, recipeRepoMock);
      },
      act: (bloc) => bloc.add(GoToInteractionPageAndExpectResult(
        BuildContextMock(), RecipeInteractionPageArguments(pageType: RecipeInteractionType.create))),
      expect: () => []
    );
  });

  group("_changeRecipesToDisplay method tests", () {
    blocTest("list of scrollable recipes is emitted",
      build: () {
        final recipes = [
          Recipe("1", "title1", "desc1", "thumbnailId1", "user1",
              const ["lbl"], const Duration(seconds: 500), 1000, 1,
              DateTime.now(), DateTime.now()),
          Recipe("2", "title2", "desc1", "thumbnailId1", "user1",
              const ["lbl"], const Duration(seconds: 500), 1000, 1,
              DateTime.now(), DateTime.now()),
        ];
        final user = User("01", "testHandler", "user1", "mail@example.com", "Pass123!", DateTime.parse("2023-11-08"));

        when(() => authRepoMock.currentUser).thenAnswer((invocation) => Future.value(user));
        when(() => recipeRepoMock.getRecipesFromUserId(any())).thenAnswer((invocation) => Future.value(recipes));
        return RecipeViewBloc(authRepoMock, navigationRepositoryMock, recipeRepoMock);
      },
      act: (bloc) => bloc.add(const ChangeRecipesToDisplay()),
      expect: () => [
        const RecipeViewState(pageLoading: true, dialogTitle: "", dialogMessage: "", recipesToDisplay: []),
        const RecipeViewState(
          pageLoading: false,
          dialogTitle: "",
          dialogMessage: "",
          recipesToDisplay: [
            ScrollItem("1", "title1", urlImage: "thumbnailId1"),
            ScrollItem("2", "title2", urlImage: "thumbnailId1")
        ])
      ]
    );
  });
}