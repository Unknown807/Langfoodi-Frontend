import 'package:http/http.dart';

class ResponseError {
  static String? getErrorMessageFromCode(String defaultErrorMessage, Response response) {
    String? errorMessage;
    switch(response.statusCode) {
      case 500:
        errorMessage = defaultErrorMessage;
        break;
      case 400:
        errorMessage = response.body;
        break;
      default:
        errorMessage = null;
        break;
    }

    return errorMessage;
  }
}