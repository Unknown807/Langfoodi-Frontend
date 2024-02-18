part of 'add_connection_bloc.dart';

class AddConnectionState extends Equatable {
  const AddConnectionState({
    required this.searchTextController,
  });

  final TextEditingController searchTextController;

  @override
  List<Object> get props => [
    searchTextController
  ];

  AddConnectionState copyWith({
    TextEditingController? searchTextController
  }) {
    return AddConnectionState(
      searchTextController: searchTextController ?? this.searchTextController
    );
  }
}