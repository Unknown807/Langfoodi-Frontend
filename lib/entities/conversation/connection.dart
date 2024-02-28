part of 'conversation_entities.dart';

class Connection extends Equatable with JsonConvertible {
  const Connection(
    this.connectionId,
    this.userId1,
    this.userId2,
    this.connectionStatus
  );

  final String connectionId;
  final String userId1;
  final String userId2;
  final String connectionStatus;

  static Connection fromJsonStr(String jsonStr, JsonWrapper jsonWrapper) {
    return Connection.fromJson(jsonWrapper.decodeData(jsonStr));
  }

  static Connection fromJson(Map jsonData) {
    return Connection(
      jsonData["connectionId"],
      jsonData["userId1"],
      jsonData["userId2"],
      jsonData["connectionStatus"]
    );
  }

  @override
  List<Object?> get props => [
    connectionId, userId1, userId2,
    connectionStatus
  ];
}