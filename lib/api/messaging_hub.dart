part of 'api.dart';

class MessagingHub {

  static const String baseUrl = "https://localhost:7120";

  final HubConnection _hubConnection;

  MessagingHub({String? url})
    : _hubConnection = HubConnectionBuilder()
      .withUrl('${url ?? baseUrl}/messaging-hub')
      .build();

  Future<void> startConnection() async {
    _hubConnection.start();
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

  void onMessageDeleted(Function(String) callback) {
    _hubConnection.on("ReceiveMessageDeletion", (arguments) {
      String messageId = arguments?[0] as String;

      callback(messageId);
    });
  }

  void onMessageMarkedAsRead(Function(String, String) callback) {
    _hubConnection.on("ReceiveMarkAsRead", (arguments) {
      String userId = arguments?[0] as String;
      String messageId = arguments?[1] as String;

      callback(messageId, userId);
    });
  }
}