part of 'http.dart';

class Request {
  final String baseUrl = "https://localhost:7120";
  final Map<String, String> baseHeaders = {
    HttpHeaders.acceptHeader: "application/json",
    HttpHeaders.contentTypeHeader: "application/json"
  };

  Map<String, String>? _formatHeaders(Map<String, String>? headers) {
    var allHeaders = {...baseHeaders};
    if (headers != null) {
      allHeaders.addAll(headers);
    }
    return allHeaders;
  }

  Future<http.Response> post<K, V>(String path, Map<K, V> data, JsonWrapper jsonWrapper, {Map<String, String>? headers}) async {
    var url = Uri.parse(baseUrl + path);
    var jsonData = jsonWrapper.encodeData(data);
    return http.post(url, body: jsonData, headers: _formatHeaders(headers));
  }

  Future<http.Response> postWithoutBody<K, V>(String path, {Map<String, String>? headers}) async {
    var url = Uri.parse(baseUrl + path);
    return http.post(url, headers: _formatHeaders(headers));
  }

  Future<http.Response> get(String path, {Map<String, String>? headers}) async {
    var url = Uri.parse(baseUrl + path);
    return http.get(url, headers: _formatHeaders(headers));
  }

  Future<http.Response> delete(String path, {Map<String, String>? headers}) async {
    var url = Uri.parse(baseUrl + path);
    return http.delete(url, headers: _formatHeaders(headers));
  }
}
