import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_social_media/pages/home/home_page.dart';

void main() {

  Widget createWidgetUnderTest() {
    return const MaterialApp(
      home: HomePage(),
    );
  }

  group("home page tests", () {
    // TODO: once static recipe data is removed, unit tests will be written
    // TODO: this is because imageUrl currently causes a network error
  });
}