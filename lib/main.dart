import 'package:flutter/material.dart';
import 'package:recipe_social_media/app/app_view.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/navigation/navig_repo.dart';
import 'package:recipe_social_media/utilities/utilities.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final authRepo = AuthenticationRepository();
  final navigRepo = NavigationRepository();
  // The below is used for testing purposes:

  // LocalStore store = LocalStore();
  // store.deleteKey("loggedInUser");

  runApp(App(authRepo: authRepo, navigRepo: navigRepo));
}