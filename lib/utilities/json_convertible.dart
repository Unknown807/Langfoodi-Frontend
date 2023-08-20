part of 'utilities.dart';

mixin JsonConvertible {
  static dynamic fromJson(String jsonStr, JsonWrapper jsonWrapper) {}

  Map toJson();

  String serialize(JsonWrapper jsonWrapper) {
    return jsonWrapper.encodeData(this);
  }
}