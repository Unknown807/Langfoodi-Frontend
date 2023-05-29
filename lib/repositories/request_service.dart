import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class RequestService {
  static const String baseUrl = "https://localhost:7120";

  static Map<String, String> getHeaders({String token = ""}) {
    return {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json"
    }..addAll(token != "" ? {HttpHeaders.authorizationHeader: token} : {});
  }

  static Future<http.Response> post<K, V>(String path, Map<K, V> data, {String token = ""}) async {
    var url = Uri.parse(baseUrl + path);
    var jsonData = jsonEncode(data);
    return http.post(url, body: jsonData, headers: getHeaders(token: token));
  }

  static Future<http.Response> get(String path, {String token = ""}) async {
    var url = Uri.parse(baseUrl + path);
    return http.get(url, headers: getHeaders(token: token));
  }

  static Future<http.Response> delete(String path, {String token = ""}) async {
    var url = Uri.parse(baseUrl + path);
    return http.delete(url, headers: getHeaders(token: token));
  }
}
