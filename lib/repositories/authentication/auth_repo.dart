import 'dart:io';

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
  final tokenKey = "authToken";

  Future<User> get currentUser async {
    String userStr = (await localStore.getKey(userKey))!;
    return User.fromJsonStr(userStr, jsonWrapper);
  }

  void setCurrentUser(User user) async {
    String userStr = user.serialize(jsonWrapper);
    localStore.setKey(userKey, userStr);
  }

  Future<bool> isAuthenticated() async {
    var (user, errorMessage) = await request.authenticate(null);
    return user != null && errorMessage == null;
  }

  Future<List<UserAccount>> _searchAndGetUsers(String path) async {
    final response = await request.postWithoutBody(path, headers: { HttpHeaders.authorizationHeader: await request.currentToken });
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
    
    var response = await request.put("/user/update", data, jsonWrapper, headers: { HttpHeaders.authorizationHeader: await request.currentToken });
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
      var (user, authToken) = request.mapAuthenticationResponse(response.body);
      localStore.setKey(userKey, user.serialize(jsonWrapper));
      localStore.setKey(tokenKey, authToken);
      return "";
    }

    return response.isBadRequest ? response.body : "Issue Signing Up";
  }

  Future<String> login(String email, String password) async {
    var data = AuthenticationAttemptContract(email: email, password: password);

    var (user, errorMessage) = await request.authenticate(data);
    if (user != null) {
      localStore.setKey(userKey, user.serialize(jsonWrapper));
      return "";
    }

    return errorMessage ?? "Issue Signing In";
  }

  Future<void> logOut() async {
    localStore.deleteKey(userKey);
    localStore.deleteKey(request.tokenKey);
  }
}
