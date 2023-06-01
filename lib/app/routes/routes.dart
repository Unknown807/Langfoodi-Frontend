import 'package:flutter/material.dart';
import 'package:recipe_social_media/pages/home/home_page.dart';
import 'package:recipe_social_media/pages/login/login_page.dart';
import 'package:recipe_social_media/app/bloc/app.dart';
import 'package:recipe_social_media/pages/splash/splash_page.dart';

List<Page<dynamic>> onGenerateAppViewPages(
    AppStatus state,
    List<Page<dynamic>> pages,
    ) {
  switch (state) {
    case AppStatus.loading:
      return [SplashPage.page()];
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}