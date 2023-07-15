import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:recipe_social_media/api/api.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/navigation/navigation_repo.dart';
import 'package:recipe_social_media/utilities/utilities.dart';

class AuthenticationRepositoryMock extends Mock implements AuthenticationRepository {}
class ClientMock extends Mock implements http.Client {}
class FunctionMock extends Mock { void call([dynamic parameter]); }
class JsonWrapperMock extends Mock implements JsonWrapper {}
class LocalStoreMock extends Mock implements LocalStore {}
class NavigationRepositoryMock extends Mock implements NavigationRepository {}
class NavigatorObserverMock extends Mock implements NavigatorObserver {}
class ResponseMock extends Mock implements http.Response {}
class RequestMock extends Mock implements Request {}