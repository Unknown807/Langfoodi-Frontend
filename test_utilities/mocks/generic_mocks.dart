import 'package:bloc_test/bloc_test.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:cloudinary_url_gen/config/cloud_config.dart';
import 'package:cloudinary_url_gen/config/cloudinary_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:recipe_social_media/api/api.dart';
import 'package:recipe_social_media/forms/bloc/base_form.dart';
import 'package:recipe_social_media/pages/login/login_bloc.dart';
import 'package:recipe_social_media/pages/recipes/recipe_view/bloc/recipe_view_bloc.dart';
import 'package:recipe_social_media/pages/register/register_bloc.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/navigation/navigation_repo.dart';
import 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';
import 'package:recipe_social_media/utilities/utilities.dart';

class AuthenticationRepositoryMock extends Mock implements AuthenticationRepository {}
class BuildContextMock extends Mock implements BuildContext {}
class ByteStreamMock extends Mock implements http.ByteStream {}
class ClientMock extends Mock implements http.Client {}
class CloudinaryMock extends Mock implements Cloudinary {}
class CloudinaryConfigMock extends Mock implements CloudinaryConfig {}
class CloudConfigMock extends Mock implements CloudConfig {}
class FunctionMock extends Mock { void call([dynamic parameter]); }
class InputStateMock extends Mock implements InputState {}
class ImageBuilderMock extends Mock implements ImageBuilder {}
class ImageTransformationBuilderMock extends Mock implements ImageTransformationBuilder {}
class JsonWrapperMock extends Mock implements JsonWrapper {}
class JsonConvertibleMock extends Mock implements JsonConvertible {}
class LocalStoreMock extends Mock implements LocalStore {}
class LoginBlocMock extends MockBloc<InputEvent, InputState> implements LoginBloc {}
class MultipartFileMock extends Mock implements http.MultipartFile {}
class MultipartFileProviderMock extends Mock implements MultipartFileProvider {}
class NavigationRepositoryMock extends Mock implements NavigationRepository {}
class NavigatorObserverMock extends Mock implements NavigatorObserver {}
class ResponseMock extends Mock implements http.Response {}
class RequestMock extends Mock implements Request {}
class RegisterBlocMock extends MockBloc<InputEvent, InputState> implements RegisterBloc {}
class ReferenceWrapperMock<T> extends Mock implements ReferenceWrapper<T> {}
class RecipeRepositoryMock extends Mock implements RecipeRepository {}
class RecipeViewBlocMock extends MockBloc<RecipeViewEvent, RecipeViewState> implements RecipeViewBloc {}
class RecipeViewStateMock extends Mock implements RecipeViewState {}
class StreamedResponseMock extends Mock implements http.StreamedResponse {}