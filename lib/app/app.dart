import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:recipe_social_media/pages/conversation/conversation_page.dart';
import 'package:recipe_social_media/pages/conversation_list/conversation_list_page.dart';
import 'package:recipe_social_media/pages/image_view/cloudinary_image_view_page.dart';
import 'package:recipe_social_media/pages/recipes/recipe_interaction/recipe_interaction_page.dart';
import 'package:recipe_social_media/pages/recipes/recipe_view/recipe_view_page.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/pages/home/home_page.dart';
import 'package:recipe_social_media/pages/login/login_page.dart';
import 'package:recipe_social_media/pages/register/register_page.dart';
import 'package:recipe_social_media/pages/splash/splash_page.dart';
import 'package:recipe_social_media/repositories/image/image_repo.dart';
import 'package:recipe_social_media/repositories/navigation/navigation_repo.dart';
import 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';
import 'package:recipe_social_media/utilities/utilities.dart';
import 'package:recipe_social_media/pages/profile_settings/profile_settings_page.dart';

export 'app.dart';

part 'app_view.dart';
part 'app_lifecycle_observer.dart';
part 'bloc/app_bloc.dart';
part 'bloc/app_event.dart';
part 'bloc/app_state.dart';