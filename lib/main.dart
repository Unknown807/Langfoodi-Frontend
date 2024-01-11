import 'dart:io';
import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:file/local.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/io_client.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/image/image_repo.dart';
import 'package:recipe_social_media/repositories/navigation/navigation_repo.dart';
import 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';
import 'package:recipe_social_media/utilities/utilities.dart';
import 'api/api.dart';
import 'app/app.dart';

// This is used for testing on Android Studio's AVD, please keep
// class MyHttpOverrides extends HttpOverrides{
//   @override
//   HttpClient createHttpClient(SecurityContext? context){
//     return super.createHttpClient(context)
//       ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
//   }
// }

Future<void> main() async {
  // Uncomment the below in order to bypass certificate issues when running AVD
  // final ioc = HttpClient();
  // ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  // final client = IOClient(ioc);

  final client = http.Client();
  ReferenceWrapper<http.Client> clientWrapper = ReferenceWrapper(client);
  const localFileSystem = LocalFileSystem();
  const secureStorage = FlutterSecureStorage();
  final multipartFileProvider = MultipartFileProvider();
  final appLifeCycleObserver = AppLifeCycleObserver(clientWrapper);

  final localStore = LocalStore(secureStorage);
  final request = Request(clientWrapper, multipartFileProvider);
  final jsonWrapper = JsonWrapper();
  final cloudinaryConfig = Cloudinary.fromCloudName(cloudName: "dqy0zu53d", apiKey: "874862783656986");
  CloudinaryContext.cloudinary = cloudinaryConfig;

  // Widget Utilities
  final imageTransformationBuilder = ImageTransformationBuilder();
  final imageBuilder = ImageBuilder(imageTransformationBuilder, localFileSystem);

  // Repositories
  final navigationRepo = NavigationRepository();
  final authRepo = AuthenticationRepository(localStore, request, jsonWrapper);
  final imageRepo = ImageRepository(request, jsonWrapper, cloudinaryConfig);
  final recipeRepo = RecipeRepository(request, jsonWrapper);

  // The below 2 lines are used for manual testing purposes:
  // localStore.deleteKey("loggedInUser");
  //HttpOverrides.global = MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();

  runApp(App(
    authRepo: authRepo,
    navigationRepo: navigationRepo,
    imageRepo: imageRepo,
    recipeRepo: recipeRepo,
    imageTransformationBuilder: imageTransformationBuilder,
    imageBuilder: imageBuilder
  ));

  WidgetsBinding.instance.addObserver(appLifeCycleObserver);
}