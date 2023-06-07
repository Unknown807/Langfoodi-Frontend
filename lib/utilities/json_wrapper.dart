part of 'utilities.dart';

class JsonWrapper {
  String encodeData(Object? data) {
    return json.encode(data);
  }

  dynamic decodeData(String jsonStr) {
    return json.decode(jsonStr);
  }
}