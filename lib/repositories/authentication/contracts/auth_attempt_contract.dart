
class AuthenticationAttemptContract {
  AuthenticationAttemptContract({
    required this.usernameOrEmail,
    required this.password,
  });

  final String usernameOrEmail;
  final String password;

  Map<String, String> toMap() {
    return {
      "username": usernameOrEmail,
      "password": password
    };
  }
}