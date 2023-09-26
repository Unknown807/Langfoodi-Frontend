import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/navigation/navigation_repo.dart';
import 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';
import 'package:recipe_social_media/utilities/utilities.dart';
import 'api/api.dart';
import 'app/app.dart';

Future<void> main() async {
  ReferenceWrapper<http.Client> clientWrapper = ReferenceWrapper(http.Client());
  final appLifeCycleObserver = AppLifeCycleObserver(clientWrapper);
  const secureStorage = FlutterSecureStorage();

  final localStore = LocalStore(secureStorage);
  final request = Request(clientWrapper);
  final jsonWrapper = JsonWrapper();

  // The below line is used for manual testing purposes:
  // localStore.deleteKey("loggedInUser");

  // Singleton Repositories
  RecipeRepository(request, jsonWrapper);

  // Top-level Repositories
  final authRepo = AuthenticationRepository(localStore, request, jsonWrapper);
  final navigationRepo = NavigationRepository();

  WidgetsFlutterBinding.ensureInitialized();

  User testUser = const User(id: "64d3ec96b6247bad8eef9f88", userName: "test4", email: "test4@mail.com", password: "Password123!");
  localStore.setKey("loggedInUser", jsonWrapper.encodeData(testUser.toJson()));

  runApp(App(
      authRepo: authRepo,
      navigationRepo: navigationRepo,
  ));

  WidgetsBinding.instance.addObserver(appLifeCycleObserver);
}