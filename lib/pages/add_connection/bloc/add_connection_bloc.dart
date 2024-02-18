import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';

export 'add_connection_bloc.dart';
part 'add_connection_event.dart';
part 'add_connection_state.dart';

class AddConnectionBloc extends Bloc<AddConnectionEvent, AddConnectionState> {
  AddConnectionBloc(
    this._authRepo) : super(AddConnectionState(
      searchTextController: TextEditingController()
    )) {
      //TODO: add event handlers here
    }

  final AuthenticationRepository _authRepo;
}