part of 'add_connection_bloc.dart';

class AddConnectionState extends Equatable {
  const AddConnectionState({
    required this.searchTextController,
    this.users = const [],
    this.prevSearchTerm = "",
    this.searchLoading = false
  });

  final TextEditingController searchTextController;
  final String prevSearchTerm;
  final List<UserAccount> users;
  final bool searchLoading;

  @override
  List<Object> get props => [
    searchTextController, prevSearchTerm, users,
    searchLoading
  ];

  AddConnectionState copyWith({
    TextEditingController? searchTextController,
    String? prevSearchTerm,
    List<UserAccount>? users,
    bool? searchLoading
  }) {
    return AddConnectionState(
      searchTextController: searchTextController ?? this.searchTextController,
      prevSearchTerm: prevSearchTerm ?? this.prevSearchTerm,
      users: users ?? this.users,
      searchLoading: searchLoading ?? this.searchLoading
    );
  }
}