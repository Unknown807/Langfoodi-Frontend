import 'package:recipe_social_media/utilities/utilities.dart';
import 'models/user.dart';

class AuthenticationRepository {
  AuthenticationRepository({LocalStore? localStore, Request? requestService, JsonWrapper? jsonWrapper})
      : localStore = localStore ?? LocalStore(),
        requestService = requestService ?? Request(),
        jsonWrapper = jsonWrapper ?? JsonWrapper();

  final LocalStore localStore;
  final Request requestService;
  final JsonWrapper jsonWrapper;

  Future<User> get currentUser async {
    String userStr = await localStore.getKey("loggedInUser");
    return User.deserialize(userStr, jsonWrapper);
  }

  Future<bool> isAuthenticated() async {
    String userStr = await localStore.getKey("loggedInUser");
    if (userStr.isNotEmpty) {
      User loggedInUser = User.deserialize(userStr, jsonWrapper);
      Map<String, String> headers = {
        "usernameOrEmail": loggedInUser.email!,
        "password": loggedInUser.password!
      };

      var response = await requestService.postWithoutBody("/auth/authenticate", headers: headers);
      print(response.body);
      print(response.statusCode);

      return true;
    } else {
      return false;
    }
  }

  Future<void> register(String userName, String email, String password) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    // TODO: If status code error, then use code to throw custom Exception
    // TODO: derived from code
  }

  Future<void> loginWithUserNameOrEmail(String userNameOrEmail, String password) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    // TODO: If status code error, then use code to throw custom Exception
    // TODO: derived from code
  }

  Future<void> logOut() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    //TODO: If error logging out (i.e removing local token) -> throw error
  }
}
