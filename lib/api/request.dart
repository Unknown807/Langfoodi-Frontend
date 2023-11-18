part of 'api.dart';

class Request {
  Request(this.client, this.multipartFileProvider);

  final ReferenceWrapper<http.Client> client;
  final MultipartFileProvider multipartFileProvider;
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

  Future<http.Response> post(String path, Object data, JsonWrapper jsonWrapper, {Map<String, String>? headers, String? baseUrl}) async {
    final url = Uri.parse((baseUrl ?? this.baseUrl) + path);
    final jsonData = jsonWrapper.encodeData(data);
    return client.getInstance().post(url, body: jsonData, headers: formatHeaders(headers));
  }

  Future<http.Response> postWithoutBody(String path, {Map<String, String>? headers, String? baseUrl}) async {
    final url = Uri.parse((baseUrl ?? this.baseUrl) + path);
    return client.getInstance().post(url, headers: formatHeaders(headers));
  }

  Future<http.Response> get(String path, {Map<String, String>? headers, String? baseUrl}) async {
    final url = Uri.parse((baseUrl ?? this.baseUrl) + path);
    return client.getInstance().get(url, headers: formatHeaders(headers));
  }

  Future<http.Response> delete(String path, {Map<String, String>? headers, String? baseUrl}) async {
    final url = Uri.parse((baseUrl ?? this.baseUrl) + path);
    return client.getInstance().delete(url, headers: formatHeaders(headers));
  }

  Future<http.StreamedResponse> multipartRequest(String method, String path, Map<String, String> fields, {String? filePath, String? baseUrl}) async {
    final url = Uri.parse((baseUrl ?? this.baseUrl) + path);
    final request = http.MultipartRequest(method, url);

    request.fields.addAll(fields);
    if (filePath != null) request.files.add(await multipartFileProvider.fromPath("file", filePath));

    return client.getInstance().send(request);
  }
}
