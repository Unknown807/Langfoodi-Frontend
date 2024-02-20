part of 'add_group_bloc.dart';

@immutable
sealed class AddGroupEvent extends Equatable {
  const AddGroupEvent();

  @override
  List<Object> get props => [];
}

final class GroupNameChanged extends AddGroupEvent {
  const GroupNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

final class SearchForUsers extends AddGroupEvent {
  const SearchForUsers();
}

final class SelectUser extends AddGroupEvent {
  const SelectUser(this.user);

  final UserAccount user;

  @override
  List<Object> get props => [user];
}