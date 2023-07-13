import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/navigation/navigation_repo.dart';
import 'package:recipe_social_media/utilities/utilities.dart';

class ResponseMock extends Mock implements Response {}

class ClientMock extends Mock implements Client {}

class JsonWrapperMock extends Mock implements JsonWrapper {}

class AuthenticationRepositoryMock extends Mock implements AuthenticationRepository {}

class NavigationRepositoryMock extends Mock implements NavigationRepository {}