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
      on<CreateConversation>(_createConversation);
    }

  final AuthenticationRepository _authRepo;

  void _createConversation(CreateConversation event, Emitter<AddConnectionState> emit) {
    print(event.userId);
  }

  void _searchForUsers(SearchForUsers event, Emitter<AddConnectionState> emit) async {
    final searchTerm = state.searchTextController.value.text.toLowerCase();
    if (searchTerm.isEmpty || searchTerm == state.prevSearchTerm) return;

    emit(state.copyWith(searchLoading: true));
    List<UserAccount> users = await _authRepo.searchAndGetUsers(searchTerm);

    emit(state.copyWith(
      users: users,
      prevSearchTerm: searchTerm,
      searchLoading: false
    ));
  }
}