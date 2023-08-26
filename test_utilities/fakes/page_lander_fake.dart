import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_social_media/utilities/utilities.dart';

class PageLanderFake extends StatelessWidget with Fake implements PageLander {
  const PageLanderFake({super.key, required this.pageText});

  final String pageText;

  @override
  void onLanding() {}

  @override
  Widget build(BuildContext context) {
    return Text(pageText);
  }
}