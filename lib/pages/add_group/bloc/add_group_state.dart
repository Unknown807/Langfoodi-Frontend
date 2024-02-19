part of 'add_group_bloc.dart';

class AddGroupState extends Equatable {
  const AddGroupState({
    this.pageLoading = false,
    this.groupName = const GroupName.dirty("D£&%£%"),
    this.groupNameValid = true,
    //this.selectedUsers,
    this.prevSearchTerm = "",
    this.searchLoading = false,
  });

  final bool pageLoading;
  final bool groupNameValid;
  final GroupName groupName;
  final String prevSearchTerm;
  final bool searchLoading;

  @override
  List<Object> get props => [
    pageLoading, groupName, groupNameValid,
    prevSearchTerm, searchLoading
  ];

  AddGroupState copyWith({
    bool? pageLoading,
    GroupName? groupName,
    bool? groupNameValid,
    String? prevSearchTerm,
    bool? searchLoading
  }) {
    return AddGroupState(
      pageLoading: pageLoading ?? this.pageLoading,
      groupName: groupName ?? this.groupName,
      groupNameValid: groupNameValid ?? this.groupNameValid,
      prevSearchTerm: prevSearchTerm ?? this.prevSearchTerm,
      searchLoading: searchLoading ?? this.searchLoading
    );
  }
}