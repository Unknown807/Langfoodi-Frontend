part of 'add_connection_bloc.dart';

@immutable
sealed class AddConnectionEvent extends Equatable {
  const AddConnectionEvent();

  @override
  List<Object> get props => [];
}

final class SearchForUsers extends AddConnectionEvent {
  const SearchForUsers();
}