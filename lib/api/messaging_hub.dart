part of 'api.dart';

class MessagingHub {

  static const String baseUrl = "https://localhost:7120";

  HubConnection _hubConnection;

  MessagingHub({String? url})
    : _hubConnection = HubConnectionBuilder()
      .withUrl('${url ?? baseUrl}/messaging-hub')
      .build();

  Future<void> startConnection() async {
    await _hubConnection.start();
  }

  void stopConnection() async {
    _hubConnection.stop();
  }

  void onMessageReceived(Function(dynamic) callback) {
    _hubConnection.on("ReceiveMessage", callback);
  }

  void onMessageUpdated(Function(dynamic) callback) {
    _hubConnection.on("ReceiveMessageUpdate", callback);
  }

  void onMessageDeleted(Function(dynamic) callback) {
    _hubConnection.on("ReceiveMessageDeletion", callback);
  }

  void onMessageMarkedAsRead(Function(dynamic) callback) {
    _hubConnection.on("ReceiveMarkAsRead", callback);
  }
}