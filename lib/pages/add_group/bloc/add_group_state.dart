part of 'add_group_bloc.dart';

class AddGroupState extends Equatable {
  const AddGroupState({
    this.pageLoading = false,
    this.groupName = const GroupName.dirty("D£&%£%"),
    this.groupNameValid = true
  });

  final bool pageLoading;
  final bool groupNameValid;
  final GroupName groupName;

  @override
  List<Object> get props => [
    pageLoading, groupName, groupNameValid
  ];

  AddGroupState copyWith({
    bool? pageLoading,
    GroupName? groupName,
    bool? groupNameValid
  }) {
    return AddGroupState(
      pageLoading: pageLoading ?? this.pageLoading,
      groupName: groupName ?? this.groupName,
      groupNameValid: groupNameValid ?? this.groupNameValid
    );
  }
}