part of 'api.dart';

extension ResponseExtension on http.Response {
  bool get isOk => statusCode >= 200 && statusCode < 300;
}