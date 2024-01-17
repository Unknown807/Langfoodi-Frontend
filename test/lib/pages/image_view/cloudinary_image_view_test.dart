import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_social_media/pages/image_view/cloudinary_image_view_page.dart';
import 'package:recipe_social_media/repositories/navigation/args/image_view/image_view_page_arguments.dart';
import 'package:recipe_social_media/repositories/navigation/navigation_repo.dart';
import 'package:recipe_social_media/utilities/utilities.dart';
import '../../../../test_utilities/fakes/navigator_screen_fake.dart';
import '../../../../test_utilities/mocks/generic_mocks.dart';

void main() {
  late NavigationRepositoryMock navigationRepoMock;
  late ImageBuilderMock imageBuilderMock;

  setUp(() {
    navigationRepoMock = NavigationRepositoryMock();
    imageBuilderMock = ImageBuilderMock();
    registerFallbackValue(BuildContextMock());
  });

  Widget createWidgetUnderTest(Object arguments) {
    return MaterialApp(
      routes: {
        "/": (_) => NavigatorScreenFake(
          targetScreen: MultiRepositoryProvider(
            providers: [
              RepositoryProvider<NavigationRepository>(create: (_) => navigationRepoMock),
              RepositoryProvider<ImageBuilder>(create: (_) => imageBuilderMock)
            ],
            child: const CloudinaryImageViewPage(),
          ),
          arguments: arguments
        )
      },
    );
  }

  testWidgets("UI defined and working, image (placeholder) displayed", (widgetTester) async {
    // Arrange
    when(() => imageBuilderMock.displayCloudinaryImage(
      imageUrl: any(named: "imageUrl"),
      transformationType: ImageTransformationType.high,
      errorBuilder: any(named: "errorBuilder")))
    .thenReturn(const Icon(Icons.image));

    await widgetTester.pumpWidget(createWidgetUnderTest(ImageViewPageArguments(imageUrl: "mock_image_url")));
    await widgetTester.pumpAndSettle();

    // Act & Assert
    expect(find.byIcon(Icons.arrow_circle_left_outlined), findsOneWidget);
    await widgetTester.tap(find.byType(IconButton));
    await widgetTester.pumpAndSettle();

    verify(() => navigationRepoMock.goTo(any(), "/recipe-interaction", routeType: RouteType.backLink)).called(1);
    expect(find.byIcon(Icons.image), findsOneWidget);
  });
}