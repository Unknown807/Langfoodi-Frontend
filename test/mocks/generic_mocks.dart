import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:recipe_social_media/api/api.dart';
import 'package:recipe_social_media/forms/bloc/base_form.dart';
import 'package:recipe_social_media/pages/login/login_bloc.dart';
import 'package:recipe_social_media/pages/register/register_bloc.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/navigation/navigation_repo.dart';
import 'package:recipe_social_media/utilities/utilities.dart';

class AuthenticationRepositoryMock extends Mock implements AuthenticationRepository {}
class ClientMock extends Mock implements http.Client {}
class FunctionMock extends Mock { void call([dynamic parameter]); }
class InputStateMock extends Mock implements InputState {}
class JsonWrapperMock extends Mock implements JsonWrapper {}
class LocalStoreMock extends Mock implements LocalStore {}
class LoginBlocMock extends MockBloc<InputEvent, InputState> implements LoginBloc {}
class NavigationRepositoryMock extends Mock implements NavigationRepository {}
class NavigatorObserverMock extends Mock implements NavigatorObserver {}
class ResponseMock extends Mock implements http.Response {}
class RequestMock extends Mock implements Request {}
class RegisterBlocMock extends MockBloc<InputEvent, InputState> implements RegisterBloc {}