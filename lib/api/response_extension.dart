part of 'api.dart';

extension ResponseExtension on http.Response {
  bool get isOk => statusCode >= 200 && statusCode < 300;
  bool get isBadRequest => statusCode >= 400 && statusCode < 500;
  bool get isServerError => statusCode >= 500 && statusCode < 600;
}