import 'dart:core';

class ValidationService {
  static bool isValidEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)+$")
        .hasMatch(email);
  }

  static bool isValidUserName(String userName) {
    return RegExp(r"^[a-zA-Z0-9]{3,}$")
        .hasMatch(userName);
  }

  static bool isValidPassword(String password) {
    return RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$")
            .hasMatch(password);
  }
}
