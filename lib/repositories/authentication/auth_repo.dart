import 'package:recipe_social_media/entities/user/user.dart';
import 'package:recipe_social_media/utilities/utilities.dart';
import 'package:recipe_social_media/api/api.dart';

export 'auth_repo.dart';
part 'contracts/auth_attempt_contract.dart';
part 'contracts/new_user_contract.dart';
part 'contracts/update_user_contract.dart';

class AuthenticationRepository {
  AuthenticationRepository(this.localStore, this.request, this.jsonWrapper);

  final LocalStore localStore;
  final Request request;
  final JsonWrapper jsonWrapper;
  final userKey = "loggedInUser";

  Future<User> get currentUser async {
    String userStr = await localStore.getKey(userKey);
    return User.fromJsonStr(userStr, jsonWrapper);
  }

  Future<bool> isAuthenticated() async {
    String userStr = await localStore.getKey(userKey);
    if (userStr.isNotEmpty) {
      User loggedInUser = User.fromJsonStr(userStr, jsonWrapper);

      var data = AuthenticationAttemptContract(
          usernameOrEmail: loggedInUser.email ?? loggedInUser.userName!,
          password: loggedInUser.password!);

      var response = await request.post("/auth/authenticate", data, jsonWrapper);
      return response.statusCode == 200 && response.body.toLowerCase() == "true";
    }

    return false;
  }

  Future<String?> register(String username, String email, String password) async {
    var data = NewUserContract(username: username, email: email, password: password);

    var response = await request.post("/user/create", data, jsonWrapper);
    if (response.statusCode == 200) {
      User user = User(userName: username, email: email, password: password);
      localStore.setKey(userKey, user.serialize(jsonWrapper));
    }

    return ResponseError.getErrorMessageFromCode("Issue Signing Up", response);
  }

  Future<String?> loginWithUserNameOrEmail(String usernameOrEmail, String password) async {
    var data = AuthenticationAttemptContract(usernameOrEmail: usernameOrEmail, password: password);

    var response = await request.post("/auth/authenticate", data, jsonWrapper);
    if (response.statusCode == 200 && response.body.toLowerCase() == "true") {
      bool isEmail = usernameOrEmail.contains("@");
      User user = User(
        userName: isEmail ? "" : usernameOrEmail,
        email: isEmail ? usernameOrEmail : "",
        password: password
      );
      localStore.setKey(userKey, user.serialize(jsonWrapper));
    }

    return ResponseError.getErrorMessageFromCode("Issue Signing In", response);
  }

  Future<void> logOut() async {
    localStore.deleteKey(userKey);
  }
}
