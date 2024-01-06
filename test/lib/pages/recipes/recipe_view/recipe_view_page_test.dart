import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_social_media/pages/recipes/recipe_view/bloc/recipe_view_bloc.dart';
import 'package:recipe_social_media/pages/recipes/recipe_view/recipe_view_page.dart';
import 'package:recipe_social_media/repositories/navigation/args/recipe_interaction/recipe_interaction_page_arguments.dart';
import 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';
import 'package:recipe_social_media/utilities/utilities.dart';
import 'package:recipe_social_media/widgets/shared_widgets.dart';
import '../../../../../test_utilities/mocks/generic_mocks.dart';

void main() {
  late RecipeViewStateMock recipeViewStateMock;
  late RecipeViewBlocMock recipeViewBlocMock;
  late ImageBuilderMock imageBuilderMock;

  setUp(() {
    recipeViewStateMock = RecipeViewStateMock();
    recipeViewBlocMock = RecipeViewBlocMock();
    imageBuilderMock = ImageBuilderMock();

    when(() => recipeViewStateMock.searchSuggestions).thenReturn(["s1", "s2", "s3"]);
    when(() => recipeViewStateMock.pageLoading).thenReturn(false);
    when(() => recipeViewBlocMock.state).thenReturn(recipeViewStateMock);
    when(() => imageBuilderMock.decideOnAndDisplayImage(
      isAsset: true,
      imageUrl: any(named: "imageUrl"),
      transformationType: ImageTransformationType.standard,
      errorBuilder: any(named: "errorBuilder")
    )).thenReturn(const Icon(Icons.image));

    registerFallbackValue(
      GoToInteractionPageAndExpectResult(
        BuildContextMock(),
        RecipeInteractionPageArguments(pageType: RecipeInteractionType.create)
      )
    );
  });

  Widget createWidgetUnderTest() {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<RecipeRepository>(create: (_) => RecipeRepositoryMock()),
        RepositoryProvider<ImageBuilder>(create: (_) => imageBuilderMock),
      ],
      child: BlocProvider<RecipeViewBloc>(
        create: (recipeRepoContext) => recipeViewBlocMock,
        child: const MaterialApp(
          home: RecipeViewPage(key: Key("recipeViewPageTest")),
        )
      )
    );
  }

  group("onLanding method tests", () {
    testWidgets("ChangeRecipesToDisplay event is sent", (widgetTester) async {
      // Arrange
      when(() => recipeViewStateMock.recipesToDisplay).thenReturn([]);
      when(() => recipeViewBlocMock.state).thenReturn(recipeViewStateMock);
      await widgetTester.pumpWidget(createWidgetUnderTest());

      BuildContext context = widgetTester.element(find.byKey(const Key("recipeViewPageTest")));
      final recipeViewPage = (widgetTester.widget<Widget>(find.byKey(const Key("recipeViewPageTest"))) as RecipeViewPage);

      // Act
      recipeViewPage.onLanding(context);

      // Assert
      verify(() => recipeViewBlocMock.add(const ChangeRecipesToDisplay())).called(1);
    });
  });

  testWidgets("Page is loading", (widgetTester) async {
    // Arrange
    when(() => recipeViewStateMock.pageLoading).thenReturn(true);
    await widgetTester.pumpWidget(createWidgetUnderTest());

    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets("Floating button (create recipe) works", (widgetTester) async {
    // Arrange
    when(() => recipeViewStateMock.recipesToDisplay).thenReturn([]);
    await widgetTester.pumpWidget(createWidgetUnderTest());

    // Act
    await widgetTester.tap(find.byType(CustomFloatingButton));

    // Assert
    verify(() => recipeViewBlocMock.add(any<RecipeViewEvent>())).called(1);
  });

  testWidgets("Empty recipes to display list", (widgetTester) async {
    // Arrange
    when(() => recipeViewStateMock.recipesToDisplay).thenReturn([]);
    await widgetTester.pumpWidget(createWidgetUnderTest());

    // Assert
    expect(find.text("Search Your Recipes"), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);
    expect(find.byIcon(Icons.image), findsNothing);
    expect(find.byType(CustomFloatingButton), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets("Populated recipes to display list", (widgetTester) async {
    // Arrange
    when(() => recipeViewStateMock.recipesToDisplay).thenReturn([
      ScrollItem("1", "title1", urlImage: "https://daniscookings.com/wp-content/uploads/2021/03/Cinnamon-Roll-Cake-23.jpg"),
      ScrollItem("2", "title2", urlImage: "https://daniscookings.com/wp-content/uploads/2021/03/Cinnamon-Roll-Cake-24.jpg"),
    ]);
    await widgetTester.pumpWidget(createWidgetUnderTest());

    // Act
    final gesture = await widgetTester.startGesture(const Offset(50, 100));
    // Scrolling down the screen to see both recipes
    await gesture.moveBy(const Offset(0, 100));
    await widgetTester.pumpAndSettle();
    
    // Assert
    expect(find.text("Search Your Recipes"), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);
    expect(find.text("title1"), findsOneWidget);
    expect(find.text("title2"), findsOneWidget);
    expect(find.byIcon(Icons.image), findsNWidgets(2));
    expect(find.byType(CustomFloatingButton), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}
