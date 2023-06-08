part of 'utilities.dart';

class JsonWrapper {
  String encodeData(Object? data) {
    return json.encode(data);
  }

  Map<String, dynamic> decodeData(String jsonStr) {
    return json.decode(jsonStr);
  }
}