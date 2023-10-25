part of 'api.dart';

extension StreamedResponseExtension on http.StreamedResponse {
  bool get isOk => statusCode >= 200 && statusCode < 300;
}