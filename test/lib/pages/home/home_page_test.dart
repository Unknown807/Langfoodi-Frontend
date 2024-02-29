import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_social_media/api/api.dart';
import 'package:recipe_social_media/entities/user/user_entities.dart';
import 'package:recipe_social_media/pages/home/home_page.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/conversation/conversation_repo.dart';
import 'package:recipe_social_media/repositories/image/image_repo.dart';
import 'package:recipe_social_media/repositories/navigation/navigation_repo.dart';
import 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';
import 'package:recipe_social_media/utilities/utilities.dart';
import '../../../../test_utilities/mocks/generic_mocks.dart';

void main() {
  late ConversationRepositoryMock conversationRepoMock;
  late AuthenticationRepositoryMock authRepoMock;
  late MessagingHubMock messagingHubMock;

  setUp(() {
    conversationRepoMock = ConversationRepositoryMock();
    authRepoMock = AuthenticationRepositoryMock();
    messagingHubMock = MessagingHubMock();
  });

  Widget createWidgetUnderTest() {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ConversationRepository>(create: (_) => conversationRepoMock),
        RepositoryProvider<RecipeRepository>(create: (_) => RecipeRepositoryMock()),
        RepositoryProvider<AuthenticationRepository>(create: (_) => authRepoMock),
        RepositoryProvider<NavigationRepository>(create: (_) => NavigationRepositoryMock()),
        RepositoryProvider<NetworkManager>(create: (_) => NetworkManagerMock()),
        RepositoryProvider<ImageRepository>(create: (_) => ImageRepositoryMock()),
        RepositoryProvider<MessagingHub>(create: (_) => messagingHubMock),
      ],
      child: const MaterialApp(
        home: HomePage(),
      ));
  }

  group("home page tests", () {
    testWidgets("All home page tabs exist", (widgetTester) async {
      // Arrange
      when(() => conversationRepoMock.getConversationByUser(any())).thenAnswer((invocation) => Future.value([]));
      when(() => authRepoMock.currentUser).thenAnswer((invocation) => Future.value(
          User("1", "handle", "username", "email", "pass", DateTime(2024), null, const [], const []))
      );
      await widgetTester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.byIcon(Icons.chat), findsOneWidget);
      expect(find.text("Conversations"), findsNWidgets(2));
      expect(find.byIcon(Icons.fastfood), findsOneWidget);
      expect(find.text("My Recipes"), findsOneWidget);
      expect(find.byIcon(Icons.person), findsAtLeastNWidgets(1));
      expect(find.text("Profile"), findsOneWidget);
    });
  });
}
