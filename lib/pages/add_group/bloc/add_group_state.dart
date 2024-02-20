part of 'add_group_bloc.dart';

class AddGroupState extends Equatable {
  const AddGroupState({
    required this.searchTextController,
    this.pageLoading = false,
    this.groupName = const GroupName.pure(),
    this.groupNameValid = true,
    this.prevSearchTerm = "",
    this.searchLoading = false,
    this.searchedUsers = const [],
    this.selectedUsers = const[]
  });

  final TextEditingController searchTextController;
  final bool pageLoading;
  final bool groupNameValid;
  final GroupName groupName;
  final String prevSearchTerm;
  final bool searchLoading;
  final List<UserAccount> searchedUsers;
  final List<UserAccount> selectedUsers;

  @override
  List<Object> get props => [
    pageLoading, groupName, groupNameValid,
    prevSearchTerm, searchLoading, searchTextController,
    searchedUsers, selectedUsers
  ];

  AddGroupState copyWith({
    bool? pageLoading,
    GroupName? groupName,
    bool? groupNameValid,
    String? prevSearchTerm,
    bool? searchLoading,
    TextEditingController? searchTextController,
    List<UserAccount>? searchedUsers,
    List<UserAccount>? selectedUsers
  }) {
    return AddGroupState(
      pageLoading: pageLoading ?? this.pageLoading,
      groupName: groupName ?? this.groupName,
      groupNameValid: groupNameValid ?? this.groupNameValid,
      prevSearchTerm: prevSearchTerm ?? this.prevSearchTerm,
      searchLoading: searchLoading ?? this.searchLoading,
      searchTextController: searchTextController ?? this.searchTextController,
      searchedUsers: searchedUsers ?? this.searchedUsers,
      selectedUsers: selectedUsers ?? this.selectedUsers
    );
  }
}