part of 'utilities.dart';

mixin JsonConvertible {
  static dynamic fromJsonStr(String jsonStr, JsonWrapper jsonWrapper) {}
  static dynamic fromJson(Map jsonData, JsonWrapper jsonWrapper) {}

  Map? toJson() {}

  String serialize(JsonWrapper jsonWrapper) {
    return jsonWrapper.encodeData(this);
  }
}