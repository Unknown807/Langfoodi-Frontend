import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:recipe_social_media/pages/recipes/recipe_creation/recipe_interaction_page.dart';
import 'package:recipe_social_media/pages/recipes/recipe_view/recipe_view_page.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';

import 'package:recipe_social_media/pages/home/home_page.dart';
import 'package:recipe_social_media/pages/login/login_page.dart';
import 'package:recipe_social_media/pages/register/register_page.dart';
import 'package:recipe_social_media/pages/splash/splash_page.dart';
import 'package:recipe_social_media/repositories/navigation/navigation_repo.dart';
import 'package:recipe_social_media/utilities/utilities.dart';

export 'app.dart';

part 'app_view.dart';
part 'app_lifecycle_observer.dart';
part 'bloc/app_bloc.dart';
part 'bloc/app_event.dart';
part 'bloc/app_state.dart';