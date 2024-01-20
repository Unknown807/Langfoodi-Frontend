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
  late NetworkManagerMock networkManagerMock;

  final recipes = [
    Recipe("1", "title1", "desc1", "thumbnailId1", "user1",
        const ["lbl"], const Duration(seconds: 500), 1000, 1,
        DateTime.now(), DateTime.now()),
    Recipe("2", "title2", "desc1", "thumbnailId2", "user1",
        const ["lbl"], const Duration(seconds: 500), 1000, 1,
        DateTime.now(), DateTime.now()),
    Recipe("3", "title3", "desc1", "thumbnailId3", "user1",
        const ["lbl"], const Duration(seconds: 500), 1000, 1,
        DateTime.now(), DateTime.now()),
    Recipe("4", "recipe4", "desc1", "thumbnailId4", "user1",
        const ["lbl"], const Duration(seconds: 500), 1000, 1,
        DateTime.now(), DateTime.now()),
    Recipe("5", "recipe5", "desc1", "thumbnailId5", "user1",
        const ["lbl"], const Duration(seconds: 500), 1000, 1,
        DateTime.now(), DateTime.now()),
    Recipe("6", "recipe6", "desc1", "thumbnailId6", "user1",
        const ["lbl"], const Duration(seconds: 500), 1000, 1,
        DateTime.now(), DateTime.now()),
  ];

  final user = User("01", "testHandler", "user1", "mail@example.com", "Pass123!", DateTime.parse("2023-11-08"));

  setUp(() {
    navigationRepositoryMock = NavigationRepositoryMock();
    authRepoMock = AuthenticationRepositoryMock();
    recipeRepoMock = RecipeRepositoryMock();
    networkManagerMock = NetworkManagerMock();

    when(() => authRepoMock.currentUser).thenAnswer((invocation) => Future.value(user));
    when(() => recipeRepoMock.getRecipesFromUserId(any())).thenAnswer((invocation) => Future.value(recipes));
    when(() => networkManagerMock.isNetworkConnected()).thenAnswer((invocation) => Future.value(true));

    registerFallbackValue(BuildContextMock());
  });

  group("_removeRecipe method tests", () {
    blocTest("recipe removal success",
      build: () {
        when(() => recipeRepoMock.removeRecipe("recipeId1")).thenAnswer((invocation) => Future.value(true));
        return RecipeViewBloc(authRepoMock, navigationRepositoryMock, recipeRepoMock, networkManagerMock);
      },
      act: (bloc) => bloc.add(const RemoveRecipe("recipeId1")),
      expect: () => [
        const RecipeViewState(pageLoading: true),
        const RecipeViewState(pageLoading: true, dialogTitle: "Recipe Removed!", dialogMessage: "Recipe was successfully removed")
      ]
    );

    blocTest("recipe removal failure",
      build: () {
        when(() => recipeRepoMock.removeRecipe("recipeId1")).thenAnswer((invocation) => Future.value(false));
        return RecipeViewBloc(authRepoMock, navigationRepositoryMock, recipeRepoMock, networkManagerMock);
      },
      act: (bloc) => bloc.add(const RemoveRecipe("recipeId1")),
      expect: () => [
        const RecipeViewState(pageLoading: true),
        const RecipeViewState(pageLoading: true, dialogTitle: "Oops!", dialogMessage: "Something went wrong, recipe was not removed")
      ]
    );
  });

  group("_searchTermChanged method tests", () {
    blocTest("same search term as previously, so ignore",
        build: () => RecipeViewBloc(authRepoMock, navigationRepositoryMock, recipeRepoMock, networkManagerMock),
        act: (bloc) {
          bloc.add(const ChangeRecipesToDisplay());
          Future.delayed(const Duration(milliseconds: 100), () {
            bloc.add(const SearchTermChanged("title"));
            Future.delayed(const Duration(milliseconds: 100), () {
              bloc.add(const SearchTermChanged("t"));
            });
          });
        },
        skip: 3,
        wait: const Duration(milliseconds: 400),
        expect: () => [
          RecipeViewState(
            prevSearchTerm: "t",
            searchSuggestions: const ["title1", "title2", "title3"],
            recipesToDisplay: [
              ScrollItem("1", "title1", urlImage: "thumbnailId1"),
              ScrollItem("2", "title2", urlImage: "thumbnailId2"),
              ScrollItem("3", "title3", urlImage: "thumbnailId3"),
              ScrollItem("4", "recipe4", urlImage: "thumbnailId4", show: false),
              ScrollItem("5", "recipe5", urlImage: "thumbnailId5", show: false),
              ScrollItem("6", "recipe6", urlImage: "thumbnailId6", show: false)
            ]
          )
        ]
    );

    blocTest("empty search term, so show=true on all recipes",
      build: () => RecipeViewBloc(authRepoMock, navigationRepositoryMock, recipeRepoMock, networkManagerMock)
        ..add(const ChangeRecipesToDisplay())
        ..add(const SearchTermChanged("a")),
      act: (bloc) => bloc.add(const SearchTermChanged("")),
      skip: 3,
      expect: () => [
        RecipeViewState(
          prevSearchTerm: "",
          searchSuggestions: const [],
          recipesToDisplay: [
            ScrollItem("1", "title1", urlImage: "thumbnailId1"),
            ScrollItem("2", "title2", urlImage: "thumbnailId2"),
            ScrollItem("3", "title3", urlImage: "thumbnailId3"),
            ScrollItem("4", "recipe4", urlImage: "thumbnailId4"),
            ScrollItem("5", "recipe5", urlImage: "thumbnailId5"),
            ScrollItem("6", "recipe6", urlImage: "thumbnailId6")
          ]
        )
      ]
    );

    blocTest("non-empty search term, so show=false on some recipes",
        build: () => RecipeViewBloc(authRepoMock, navigationRepositoryMock, recipeRepoMock, networkManagerMock),
        act: (bloc) {
          bloc.add(const ChangeRecipesToDisplay());
          Future.delayed(const Duration(milliseconds: 100), () {
            bloc.add(const SearchTermChanged("t"));
            Future.delayed(const Duration(milliseconds: 100), () {
              bloc.add(const SearchTermChanged("title"));
            });
          });
        },
        skip: 3,
        wait: const Duration(milliseconds: 400),
        expect: () => [
          RecipeViewState(
            prevSearchTerm: "title",
            searchSuggestions: const ["title1", "title2", "title3"],
            recipesToDisplay: [
              ScrollItem("1", "title1", urlImage: "thumbnailId1"),
              ScrollItem("2", "title2", urlImage: "thumbnailId2"),
              ScrollItem("3", "title3", urlImage: "thumbnailId3"),
              ScrollItem("4", "recipe4", urlImage: "thumbnailId4", show: false),
              ScrollItem("5", "recipe5", urlImage: "thumbnailId5", show: false),
              ScrollItem("6", "recipe6", urlImage: "thumbnailId6", show: false)
            ]
          )
        ]
    );
  });

  group("_goToInteractionPageAndExpectResult method tests", () {
    blocTest("successMessage is emitted",
      build: () {
        when(() => navigationRepositoryMock.goTo(
            any(), "/recipe-interaction",
            routeType: RouteType.expect, arguments: any(named: "arguments")))
        .thenAnswer((invocation) => Future.value(null));

        return RecipeViewBloc(authRepoMock, navigationRepositoryMock, recipeRepoMock, networkManagerMock);
      },
      act: (bloc) => bloc.add(GoToInteractionPageAndExpectResult(
        BuildContextMock(), RecipeInteractionPageArguments(pageType: RecipeInteractionType.create))),
      expect: () => []
    );
  });

  group("_changeRecipesToDisplay method tests", () {
    blocTest("list of scrollable recipes is emitted",
      build: () => RecipeViewBloc(authRepoMock, navigationRepositoryMock, recipeRepoMock, networkManagerMock),
      act: (bloc) => bloc.add(const ChangeRecipesToDisplay()),
      expect: () => [
        const RecipeViewState(pageLoading: true, dialogTitle: "", dialogMessage: "", recipesToDisplay: []),
        RecipeViewState(
          pageLoading: false,
          dialogTitle: "",
          dialogMessage: "",
          recipesToDisplay: [
            ScrollItem("1", "title1", urlImage: "thumbnailId1"),
            ScrollItem("2", "title2", urlImage: "thumbnailId2"),
            ScrollItem("3", "title3", urlImage: "thumbnailId3"),
            ScrollItem("4", "recipe4", urlImage: "thumbnailId4"),
            ScrollItem("5", "recipe5", urlImage: "thumbnailId5"),
            ScrollItem("6", "recipe6", urlImage: "thumbnailId6")
        ])
      ]
    );

    blocTest("network connectivity issue, no recipes retrieved",
      build: () {
        when(() => networkManagerMock.isNetworkConnected()).thenAnswer((invocation) => Future.value(false));
        return RecipeViewBloc(authRepoMock, navigationRepositoryMock, recipeRepoMock, networkManagerMock);
      },
      skip: 1,
      act: (bloc) => bloc.add(const ChangeRecipesToDisplay()),
      expect: () => [
        const RecipeViewState(pageLoading: false, networkIssue: true)
      ]
    );
  });
}