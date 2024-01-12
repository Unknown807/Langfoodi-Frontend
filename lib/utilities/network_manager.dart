part of 'utilities.dart';

class NetworkManager {
  Future<bool> isNetworkConnected() {
    return InternetConnectionChecker().hasConnection;
  }
}