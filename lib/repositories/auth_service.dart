import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:recipe_social_media/repositories/request_service.dart';

class AuthService {
  static const _storage = FlutterSecureStorage();

  static bool tokenExists() {
    String? token = getToken();
    return token != null;
  }

  static String? getToken() {
    String? authToken;
    _storage.read(key: "authToken").then((value) => authToken = value);
    return authToken;
  }

  static void setToken(String token) async {
    await _storage.write(key: "authToken", value: token);
  }

  static Future<Response> attemptLogin(String userNameOrEmail, String password) {
    var user = {
      "password": password,
      "email": userNameOrEmail,
      "username": userNameOrEmail
    };

    return RequestService.post("/tokens/login", user);
  }

  static Future<Response> attemptRegister(String userName, String email, String password) {
    var user = {
      "username": userName,
      "email": email,
      "password": password
    };

    return RequestService.post("/users/createuser", user);
  }

  // static bool userNameExists(String userName) {
  //   var user = {
  //     "username": userName,
  //     "email": "",
  //     "password": ""
  //   };
  //
  //   bool exists = false;
  //   RequestService.post("/users/username/exists", user).then((value) => exists = jsonDecode(value.body));
  //
  //   return exists;
  // }
  //
  // static bool emailExists(String email) {
  //   var user = {
  //     "email": email,
  //     "username": "",
  //     "password": ""
  //   };
  //
  //   bool exists = false;
  //   RequestService.post("/users/email/exists", user).then((value) => exists = jsonDecode(value.body));
  //
  //   return exists;
  // }
}