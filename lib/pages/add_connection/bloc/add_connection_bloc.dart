import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:recipe_social_media/entities/user/user_entities.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';

export 'add_connection_bloc.dart';
part 'add_connection_event.dart';
part 'add_connection_state.dart';

class AddConnectionBloc extends Bloc<AddConnectionEvent, AddConnectionState> {
  AddConnectionBloc(
    this._authRepo) : super(AddConnectionState(
      searchTextController: TextEditingController()
    )) {
      on<SearchForUsers>(_searchForUsers);
    }

  final AuthenticationRepository _authRepo;

  void _searchForUsers(SearchForUsers event, Emitter<AddConnectionState> emit) {
    final searchTerm = state.searchTextController.value.text.toLowerCase();
    if (searchTerm.isEmpty || searchTerm == state.prevSearchTerm) return;

    //TODO: get list of users here
    List<UserAccount> users = [
      UserAccount("1", "handle1", "username1", DateTime.now(), "pzkr9msh3kumhsxxakfa", const []),
      UserAccount("2", "handle2", "username2", DateTime.now(), null, const []),
      UserAccount("3", "handle3", "username3", DateTime.now(), "pzkr9msh3kumhsxxakfaWRONG", const [])
    ];

    emit(state.copyWith(
      users: users,
      prevSearchTerm: searchTerm,
    ));
  }
}