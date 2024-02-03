import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:recipe_social_media/entities/user/user_entities.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';

export 'profile_settings_bloc.dart';
part 'profile_settings_event.dart';
part 'profile_settings_state.dart';

// TODO: need another bloc for editing called ProfileSettingsFormBloc
class ProfileSettingsBloc extends Bloc<ProfileSettingsEvent, ProfileSettingsState> {
  ProfileSettingsBloc(this._authRepo) : super(const ProfileSettingsState()) {
    on<DisplayProfileInformation>(_displayProfileInformation);
    on<StartEditingUsername>(_startEditingUsername);
  }

  final AuthenticationRepository _authRepo;

  void _startEditingUsername(StartEditingUsername event, Emitter<ProfileSettingsState> emit) async {
    emit(state.copyWith(
      editingUsername: true
    ));
  }

  void _displayProfileInformation(DisplayProfileInformation event, Emitter<ProfileSettingsState> emit) async {
    User user = await _authRepo.currentUser;
    emit(state.copyWith(
      creationDate: DateFormat('dd-MM-yyyy').format(user.creationDate),
      handler: user.handler,
      username: user.username,
      email: user.email,
      thumbnailId: "q8jjeukocprdiblv25tf"
    ));
  }
}