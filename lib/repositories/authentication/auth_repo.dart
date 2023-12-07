import 'package:recipe_social_media/entities/user/user_entities.dart';
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
          usernameOrEmail: loggedInUser.email,
          password: loggedInUser.password);

      var response = await request.post("/auth/authenticate", data, jsonWrapper);
      return response.isOk;
    }

    return false;
  }

  Future<String> register(String username, String email, String password) async {
    // TODO: add handler field to register page
    var data = NewUserContract(
      handler: "testHandler",
      username: username,
      email: email,
      password: password);

    var response = await request.post("/user/create", data, jsonWrapper);
    if (response.isOk) {
      User user = User.fromJsonStr(response.body, jsonWrapper);
      localStore.setKey(userKey, user.serialize(jsonWrapper));
      return "";
    }

    return response.isBadRequest ? response.body : "Issue Signing Up";
  }

  Future<String> loginWithUserNameOrEmail(String usernameOrEmail, String password) async {
    var data = AuthenticationAttemptContract(usernameOrEmail: usernameOrEmail, password: password);
    var response = await request.post("/auth/authenticate", data, jsonWrapper);

    if (response.isOk) {
      User user = User.fromJsonStr(response.body, jsonWrapper);
      localStore.setKey(userKey, user.serialize(jsonWrapper));
      return "";
    }

    return response.isBadRequest ? response.body : "Issue Signing In";
  }

  Future<void> logOut() async {
    localStore.deleteKey(userKey);
  }
}
