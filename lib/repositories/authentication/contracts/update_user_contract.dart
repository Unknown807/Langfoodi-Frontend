
class UpdateUserContract {
  UpdateUserContract({
    required this.id,
    required this.username,
    required this.email,
    required this.password
  });

  final String id;
  final String username;
  final String email;
  final String password;

  Map<String, String> toMap() {
    return {
      "id": id,
      "username": username,
      "email": email,
      "password": password
    };
  }
}