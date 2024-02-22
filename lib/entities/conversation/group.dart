part of 'conversation_entities.dart';

class Group extends Equatable with JsonConvertible {
  const Group(
    this.id,
    this.name,
    this.description,
    this.userIds
  );

  final String id;
  final String name;
  final String description;
  final List<String> userIds;

  static Group fromJsonStr(String jsonStr, JsonWrapper jsonWrapper) {
    return Group.fromJson(jsonWrapper.decodeData(jsonStr));
  }

  static Group fromJson(Map jsonData) {
    return Group(
      jsonData["id"],
      jsonData["name"],
      jsonData["description"],
      (jsonData["userIds"] as List).map((uid) => uid as String).toList()
    );
  }

  @override
  List<Object?> get props =>  [
    id, name, description, userIds
  ];
}