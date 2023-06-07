import 'package:http/http.dart' as http;
import 'package:recipe_social_media/api/response_error.dart';
import 'package:recipe_social_media/utilities/utilities.dart';
import 'package:recipe_social_media/api/api.dart';
import 'models/user.dart';

class AuthenticationRepository {
  AuthenticationRepository({LocalStore? localStore, Request? request, JsonWrapper? jsonWrapper})
      : localStore = localStore ?? LocalStore(),
        jsonWrapper = jsonWrapper ?? JsonWrapper(),
        request = request ?? Request();

  final LocalStore localStore;
  final Request request;
  final JsonWrapper jsonWrapper;

  Future<User> get currentUser async {
    String userStr = await localStore.getKey("loggedInUser");
    return User.deserialize(userStr, jsonWrapper);
  }

  Future<bool> isAuthenticated() async {
    String userStr = await localStore.getKey("loggedInUser");
    if (userStr.isNotEmpty) {
      User loggedInUser = User.deserialize(userStr, jsonWrapper);
      var headers = {
        "usernameOrEmail": loggedInUser.email!,
        "password": loggedInUser.password!
      };

      var response = await request.postWithoutBody("/auth/authenticate", headers: headers);
      print(response.body);
      print(response.statusCode);

      return true;
    } else {
      return false;
    }
  }

  Future<String?> register(String userName, String email, String password) async {
    var data = {
      "Id": null,
      "UserName": userName,
      "Email": email,
      "Password": password
    };

    var response = await request.post("/user/create", data, jsonWrapper);
    return ResponseError.getErrorMessageFromCode("Issue Signing Up", response);
  }

  Future<String?> loginWithUserNameOrEmail(String userNameOrEmail, String password) async {
    var headers = {
      "usernameOrEmail": userNameOrEmail,
      "password": password
    };

    var response = await request.postWithoutBody("/auth/authenticate", headers: headers);
    return ResponseError.getErrorMessageFromCode("Issue Signing In", response);
  }

  Future<void> logOut() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    //TODO: If error logging out (i.e removing local token) -> throw error
  }
}
