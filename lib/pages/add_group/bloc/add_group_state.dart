part of 'add_group_bloc.dart';

class AddGroupState extends Equatable {
  const AddGroupState({
    this.pageLoading = false
  });

  final bool pageLoading;

  @override
  List<Object> get props => [
    pageLoading
  ];

  AddGroupState copyWith({
    bool? pageLoading
  }) {
    return AddGroupState(
      pageLoading: pageLoading ?? this.pageLoading
    );
  }
}