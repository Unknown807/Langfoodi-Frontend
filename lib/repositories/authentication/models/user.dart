import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    this.token
  });

  final String? token;
  // TODO: could think about adding an expiry date here if its not included in the token?
  // TODO: in future, may have to add other user info like first name, photo, etc

  static const empty = User();

  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [token,];
}