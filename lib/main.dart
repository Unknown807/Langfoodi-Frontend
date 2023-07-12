import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:recipe_social_media/app/app_view.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/navigation/navigation_repo.dart';
import 'package:recipe_social_media/utilities/utilities.dart';
import 'api/api.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var client = http.Client(); // TODO: close connection before app exit
  const secureStorage = FlutterSecureStorage();

  final localStore = LocalStore(secureStorage);
  final request = Request(client);
  final jsonWrapper = JsonWrapper();

  // The below line is used for manual testing purposes:
  // localStore.deleteKey("loggedInUser");

  final authRepo = AuthenticationRepository(localStore, request, jsonWrapper);
  final navigationRepo = NavigationRepository();

  runApp(App(authRepo: authRepo, navigationRepo: navigationRepo));
}