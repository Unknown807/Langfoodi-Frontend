part of 'api.dart';

class Request {
  Request(this.client);

  final ReferenceWrapper<http.Client> client;
  final String baseUrl = "https://localhost:7120";
  final Map<String, String> baseHeaders = {
    HttpHeaders.acceptHeader: "application/json",
    HttpHeaders.contentTypeHeader: "application/json"
  };

  @visibleForTesting
  Map<String, String>? formatHeaders(Map<String, String>? headers) {
    var allHeaders = {...baseHeaders};
    if (headers != null) {
      allHeaders.addAll(headers);
    }
    return allHeaders;
  }

  Future<http.Response> post(String path, JsonConvertible data, JsonWrapper jsonWrapper, {Map<String, String>? headers}) async {
    var url = Uri.parse(baseUrl + path);
    var jsonData = jsonWrapper.encodeData(data);
    return client.getInstance().post(url, body: jsonData, headers: formatHeaders(headers));
  }

  Future<http.Response> postWithoutBody(String path, {Map<String, String>? headers}) async {
    var url = Uri.parse(baseUrl + path);
    return client.getInstance().post(url, headers: formatHeaders(headers));
  }

  Future<http.Response> get(String path, {Map<String, String>? headers}) async {
    var url = Uri.parse(baseUrl + path);
    return client.getInstance().get(url, headers: formatHeaders(headers));
  }

  Future<http.Response> delete(String path, {Map<String, String>? headers}) async {
    var url = Uri.parse(baseUrl + path);
    return client.getInstance().delete(url, headers: formatHeaders(headers));
  }
}
