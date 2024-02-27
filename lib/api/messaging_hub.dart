part of 'api.dart';

class MessagingHub {

  static const String baseUrl = "https://localhost:7120";

  final HubConnection _hubConnection;
  final JsonWrapper _jsonWrapper;

  MessagingHub(this._jsonWrapper, {String? url})
    : _hubConnection = HubConnectionBuilder()
      .withUrl('${url ?? baseUrl}/messaging-hub')
      .build();

  Future<void> startConnection() async {
  }

  void stopConnection() async {
    _hubConnection.stop();
  }

  void onMessageReceived(Function(Message, String) callback) {
    _hubConnection.on("ReceiveMessage", (arguments) {
      Message message = Message.fromJson(arguments?[0] as Map<dynamic, dynamic>);
      String conversationId = arguments?[1] as String;

      callback(message, conversationId);
    });
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