import 'package:equatable/equatable.dart';
import 'package:recipe_social_media/utilities/utilities.dart';
import 'package:recipe_social_media/api/api.dart';

export 'auth_repo.dart';
part 'models/user.dart';

class AuthenticationRepository {
  AuthenticationRepository(this.localStore, this.request, this.jsonWrapper);

  final LocalStore localStore;
  final Request request;
  final JsonWrapper jsonWrapper;
  final userKey = "loggedInUser";

  Future<User> get currentUser async {
    String userStr = await localStore.getKey(userKey);
    return User.deserialize(userStr, jsonWrapper);
  }

  Future<bool> isAuthenticated() async {
    String userStr = await localStore.getKey(userKey);
    if (userStr.isNotEmpty) {
      User loggedInUser = User.deserialize(userStr, jsonWrapper);
      var headers = {
        "usernameOrEmail": loggedInUser.email ?? loggedInUser.userName!,
        "password": loggedInUser.password!
      };

      var response = await request.postWithoutBody("/auth/authenticate", headers: headers);
      return response.statusCode == 200 && response.body.toLowerCase() == "true";
    }

    return false;
  }

  Future<String?> register(String userName, String email, String password) async {
    var data = {
      "Id": null,
      "UserName": userName,
      "Email": email,
      "Password": password
    };

    var response = await request.post("/user/create", data, jsonWrapper);
    if (response.statusCode == 200) {
      User user = User(userName: userName, email: email, password: password);
      localStore.setKey(userKey, User.serialize(user, jsonWrapper));
    }

    return ResponseError.getErrorMessageFromCode("Issue Signing Up", response);
  }

  Future<String?> loginWithUserNameOrEmail(String userNameOrEmail, String password) async {
    var headers = {
      "usernameOrEmail": userNameOrEmail,
      "password": password
    };

    var response = await request.postWithoutBody("/auth/authenticate", headers: headers);
    if (response.statusCode == 200 && response.body.toLowerCase() == "true") {
      bool isEmail = userNameOrEmail.contains("@");
      User user = User(
        userName: isEmail ? "" : userNameOrEmail,
        email: isEmail ? userNameOrEmail : "",
        password: password
      );
      localStore.setKey(userKey, User.serialize(user, jsonWrapper));
    }

    return ResponseError.getErrorMessageFromCode("Issue Signing In", response);
  }

  Future<void> logOut() async {
    localStore.deleteKey(userKey);
  }
}
