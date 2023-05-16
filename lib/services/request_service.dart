import 'dart:convert';
import 'package:http/http.dart' as http;

class RequestService {
  static const String baseUrl = "https://localhost:7120";
  static const Map<String, String> headers = {
    "Accept": "application/json",
    "content-type": "application/json"
  };

  static Future<http.Response> post<K, V>(String path, Map<K, V> data) async {
    var url = Uri.parse(baseUrl + path);
    var jsonData = jsonEncode(data);
    return http.post(url, body: jsonData, headers: headers);
  }
}
