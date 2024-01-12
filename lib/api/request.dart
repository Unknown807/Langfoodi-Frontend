part of 'api.dart';

class Request {
  Request(this.client, this.multipartFileProvider);

  final ReferenceWrapper<http.Client> client;
  final MultipartFileProvider multipartFileProvider;
  // used for Android AVD, port 10.0.2.2 forwards to localhost on PC
  //final String baseUrl = "https://10.0.2.2:7120";

  final Duration timeoutDuration = const Duration(seconds: 10);
  final http.Response generalExceptionResponse = http.Response("unknown error", 500);
  final http.Response timeoutExceptionResponse = http.Response("timeout error", 408);

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

  Future<http.Response> put(String path, Object data, JsonWrapper jsonWrapper, {Map<String, String>? headers, String? baseUrl}) async {
    final url = Uri.parse((baseUrl ?? this.baseUrl) + path);
    final jsonData = jsonWrapper.encodeData(data);
    return client.getInstance()
      .put(url, body: jsonData, headers: formatHeaders(headers))
      .timeout(timeoutDuration, onTimeout: () => timeoutExceptionResponse)
      .catchError((error, stackTrace) { return generalExceptionResponse; });
  }

  Future<http.Response> post(String path, Object data, JsonWrapper jsonWrapper, {Map<String, String>? headers, String? baseUrl}) async {
    final url = Uri.parse((baseUrl ?? this.baseUrl) + path);
    final jsonData = jsonWrapper.encodeData(data);
    return client.getInstance()
      .post(url, body: jsonData, headers: formatHeaders(headers))
      .timeout(timeoutDuration, onTimeout: () => timeoutExceptionResponse)
      .catchError((error, stackTrace) { return generalExceptionResponse; });
  }

  Future<http.Response> postWithoutBody(String path, {Map<String, String>? headers, String? baseUrl}) async {
    final url = Uri.parse((baseUrl ?? this.baseUrl) + path);
    return client.getInstance()
      .post(url, headers: formatHeaders(headers))
      .timeout(timeoutDuration, onTimeout: () => timeoutExceptionResponse)
      .catchError((error, stackTrace) { return generalExceptionResponse; });
  }

  Future<http.Response> get(String path, {Map<String, String>? headers, String? baseUrl}) async {
    final url = Uri.parse((baseUrl ?? this.baseUrl) + path);
    return client.getInstance()
      .get(url, headers: formatHeaders(headers))
      .timeout(timeoutDuration, onTimeout: () => timeoutExceptionResponse)
      .catchError((error, stackTrace) { return generalExceptionResponse; });
  }

  Future<http.Response> delete(String path, {Map<String, String>? headers, String? baseUrl}) async {
    final url = Uri.parse((baseUrl ?? this.baseUrl) + path);
    return client.getInstance()
      .delete(url, headers: formatHeaders(headers))
      .timeout(timeoutDuration, onTimeout: () => timeoutExceptionResponse)
      .catchError((error, stackTrace) { return generalExceptionResponse; });
  }

  Future<http.StreamedResponse> multipartRequest(String method, String path, Map<String, String> fields, {String? filePath, String? baseUrl}) async {
    final url = Uri.parse((baseUrl ?? this.baseUrl) + path);
    final request = http.MultipartRequest(method, url);

    request.fields.addAll(fields);
    if (filePath != null) request.files.add(await multipartFileProvider.fromPath("file", filePath));

    return client.getInstance()
      .send(request)
      .timeout(
        timeoutDuration,
        onTimeout: () => http.StreamedResponse(Stream.fromIterable([[1,],[2,]]), 408))
      .catchError((error, stackTrace) { return generalExceptionResponse; });
  }
}
