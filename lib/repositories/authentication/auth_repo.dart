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
    String userStr = (await localStore.getKey(userKey))!;
    return User.fromJsonStr(userStr, jsonWrapper);
  }

  Future<bool> isAuthenticated() async {
    String userStr = await localStore.getKey(userKey) ?? "";
    if (userStr.isNotEmpty) {
      User loggedInUser = User.fromJsonStr(userStr, jsonWrapper);

      var data = AuthenticationAttemptContract(
          handlerOrEmail: loggedInUser.email,
          password: loggedInUser.password);

      var response = await request.post("/auth/authenticate", data, jsonWrapper);
      return response.isOk;
    }

    return false;
  }

  Future<List<UserAccount>> _searchAndGetUsers(String path) async {
    final response = await request.postWithoutBody(path);
    if (!response.isOk) return [];

    List<dynamic> jsonUserAccounts = jsonWrapper.decodeData(response.body);
    List<UserAccount> retrievedUserAccounts = jsonUserAccounts
        .map((jsonUserAccount) => UserAccount.fromJson(jsonUserAccount))
        .toList();

    return retrievedUserAccounts;
  }

  Future<List<UserAccount>> searchAndGetUnconnectedUsers(String searchTerm, String userId) async {
    return _searchAndGetUsers("/user/get-unconnected?containedString=$searchTerm&userId=$userId");
  }

  Future<List<UserAccount>> searchAndGetConnectedUsers(String searchTerm, String userId) async {
    return _searchAndGetUsers("/user/get-connected?containedString=$searchTerm&userId=$userId");
  }

  Future<String> updateUser({required String id, String? profileImageId, String? username, String? email, String? password}) async {
    var data = UpdateUserContract(
      id: id,
      username: username,
      email: email,
      password: password,
      profileImageId: profileImageId
    );
    
    var response = await request.put("/user/update", data, jsonWrapper);
    if (response.isOk) return "";

    return response.isBadRequest ? response.body : "Issue Updating Profile";
  }

  Future<String> register(String handler, String username, String email, String password) async {
    var data = NewUserContract(
      handler: handler,
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

  Future<String> loginWithHandlerOrEmail(String handlerOrEmail, String password) async {
    var data = AuthenticationAttemptContract(handlerOrEmail: handlerOrEmail, password: password);
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
