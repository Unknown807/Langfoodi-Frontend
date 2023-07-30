import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:recipe_social_media/pages/login/login_page.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import '../../../test_utilities/mocks/generic_mocks.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late AuthenticationRepositoryMock authRepoMock;

  setUp(() {
    authRepoMock = AuthenticationRepositoryMock();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: RepositoryProvider<AuthenticationRepository>(
        create: (context) => authRepoMock,
        child: const LoginPage(),
      ),
    );
  }

  group("Valid login form submission", () {

  });

  group("Invalid login form submission", () {

  });
}