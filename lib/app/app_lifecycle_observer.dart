part of 'app.dart';

class AppLifeCycleObserver extends WidgetsBindingObserver {
  AppLifeCycleObserver(this.httpClient);

  ReferenceWrapper<Client> httpClient;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      httpClient.getInstance().close();
    } else if (state == AppLifecycleState.resumed) {
      httpClient.setInstance(Client());
    }
  }
}