part of 'add_connection_bloc.dart';

class AddConnectionState extends Equatable {
  const AddConnectionState({
    required this.searchTextController,
    this.users = const [],
    this.prevSearchTerm = "",
  });

  final TextEditingController searchTextController;
  final String prevSearchTerm;
  final List<UserAccount> users;

  @override
  List<Object> get props => [
    searchTextController, prevSearchTerm, users,
  ];

  AddConnectionState copyWith({
    TextEditingController? searchTextController,
    String? prevSearchTerm,
    List<UserAccount>? users,
  }) {
    return AddConnectionState(
      searchTextController: searchTextController ?? this.searchTextController,
      prevSearchTerm: prevSearchTerm ?? this.prevSearchTerm,
      users: users ?? this.users,
    );
  }
}