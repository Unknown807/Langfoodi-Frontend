import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_social_media/pages/recipes/recipe_view/bloc/recipe_view_bloc.dart';
import 'package:recipe_social_media/pages/recipes/recipe_view/recipe_view_page.dart';
import 'package:recipe_social_media/widgets/shared_widgets.dart';
import '../../../../../test_utilities/mocks/generic_mocks.dart';

void main() {
  late RecipeViewStateMock recipeViewStateMock;
  late RecipeViewBlocMock recipeViewBlocMock;

  setUp(() {
    recipeViewStateMock = RecipeViewStateMock();
    recipeViewBlocMock = RecipeViewBlocMock();

    when(() => recipeViewStateMock.pageLoading).thenReturn(false);
    when(() => recipeViewBlocMock.state).thenReturn(recipeViewStateMock);
  });

  Widget createWidgetUnderTest() {
    return RepositoryProvider(
        create: (_) => RecipeRepositoryMock(),
        child: BlocProvider<RecipeViewBloc>(
            create: (recipeRepoContext) => recipeViewBlocMock,
            child: const MaterialApp(
              home: RecipeViewPage(key: Key("recipeViewPage")),
            )));
  }

  group("onLanding method tests", () {
    testWidgets("ChangeRecipesToDisplay event is sent", (widgetTester) async {
      // Arrange
      when(() => recipeViewStateMock.recipesToDisplay).thenReturn([]);
      when(() => recipeViewBlocMock.state).thenReturn(recipeViewStateMock);
      await widgetTester.pumpWidget(createWidgetUnderTest());

      BuildContext context = widgetTester.element(find.byKey(const Key("recipeViewPage")));
      final recipeViewPage = (widgetTester.widget<Widget>(find.byKey(const Key("recipeViewPage"))) as RecipeViewPage);

      // Act
      recipeViewPage.onLanding(context);

      // Assert
      verify(() => recipeViewBlocMock.add(const ChangeRecipesToDisplay())).called(1);
    });
  });

  group("searchBarSuggestionsBuilder method tests", () {
    //TODO: write tests when method is fully implemented
  });

  testWidgets("Page is loading", (widgetTester) async {
    // Arrange
    when(() => recipeViewStateMock.pageLoading).thenReturn(true);
    await widgetTester.pumpWidget(createWidgetUnderTest());

    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets("Empty recipes to display list", (widgetTester) async {
    // Arrange
    when(() => recipeViewStateMock.recipesToDisplay).thenReturn([]);
    await widgetTester.pumpWidget(createWidgetUnderTest());

    // Assert
    expect(find.text("Search Your Recipes"), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);
    expect(find.text("+ Filter"), findsOneWidget);
  });

  testWidgets("Populated recipes to display list", (widgetTester) async {
    // Arrange
    when(() => recipeViewStateMock.recipesToDisplay).thenReturn(const [
      ScrollItem("1", "https://daniscookings.com/wp-content/uploads/2021/03/Cinnamon-Roll-Cake-23.jpg", "title1", subtitle: "subtitle1"),
      ScrollItem("2", "https://daniscookings.com/wp-content/uploads/2021/03/Cinnamon-Roll-Cake-23.jpg", "title2")
    ]);
    await widgetTester.pumpWidget(createWidgetUnderTest());

    // Assert
    expect(find.text("Search Your Recipes"), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);
    expect(find.text("+ Filter"), findsOneWidget);
    expect(find.text("title1"), findsOneWidget);
    expect(find.text("subtitle1"), findsOneWidget);
    expect(find.text("title2"), findsOneWidget);
  });
}
