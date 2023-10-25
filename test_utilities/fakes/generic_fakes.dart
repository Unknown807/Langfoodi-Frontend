import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:recipe_social_media/utilities/utilities.dart';

class BaseRequestFake extends Fake implements BaseRequest {}
class RouteFake extends Fake implements Route<dynamic> {}
class JsonConvertibleFakeSubClass extends Fake with JsonConvertible {}