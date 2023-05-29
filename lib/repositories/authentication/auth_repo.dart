import 'package:recipe_social_media/utilities/utilities.dart';
import 'models/user.dart';

class AuthenticationRepository {
  AuthenticationRepository({LocalStore? localStore})
      : localStore = localStore ?? LocalStore();

  final LocalStore localStore;

  Future<User> get currentUser async {
    return User(token: await localStore.getKey("authToken"));
  }

  Future<bool> isAuthenticated() async {
    return await localStore.keyExists("authToken");
  }

  Future<void> register({required String userName, required String email, required String password}) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    // TODO: If status code error, then use code to throw custom Exception
    // TODO: derived from code
  }

  Future<void> loginWithUserName({required String userName, required String password}) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    // TODO: If status code error, then use code to throw custom Exception
    // TODO: derived from code
  }

  Future<void> loginWithEmail({required String email, required String password}) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    // TODO: If status code error, then use code to throw custom Exception
    // TODO: derived from code
  }

  Future<void> logOut() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    //TODO: If error logging out (i.e removing local token) -> throw error
  }
}
