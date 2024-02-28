part of 'add_connection_bloc.dart';

class AddConnectionState extends Equatable {
  const AddConnectionState({
    required this.searchTextController,
    this.users = const [],
    this.prevSearchTerm = "",
    this.searchLoading = false,
    this.pageLoading = false,
    this.dialogTitle = "",
    this.dialogMessage = "",
    this.formSuccess = false,
  });

  final TextEditingController searchTextController;
  final String prevSearchTerm;
  final List<UserAccount> users;
  final bool searchLoading;
  final bool pageLoading;
  final bool formSuccess;
  final String dialogTitle;
  final String dialogMessage;

  @override
  List<Object> get props => [
    searchTextController, prevSearchTerm, users,
    searchLoading, pageLoading, dialogTitle,
    dialogMessage, formSuccess
  ];

  AddConnectionState copyWith({
    TextEditingController? searchTextController,
    String? prevSearchTerm,
    List<UserAccount>? users,
    bool? searchLoading,
    bool? pageLoading,
    bool? formSuccess,
    String? dialogTitle,
    String? dialogMessage
  }) {
    return AddConnectionState(
      searchTextController: searchTextController ?? this.searchTextController,
      prevSearchTerm: prevSearchTerm ?? this.prevSearchTerm,
      users: users ?? this.users,
      searchLoading: searchLoading ?? this.searchLoading,
      pageLoading: pageLoading ?? this.pageLoading,
      dialogTitle: dialogTitle ?? this.dialogTitle,
      dialogMessage: dialogMessage ?? this.dialogMessage,
      formSuccess: formSuccess ?? this.formSuccess
    );
  }
}