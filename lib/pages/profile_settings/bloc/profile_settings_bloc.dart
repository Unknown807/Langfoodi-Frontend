import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:recipe_social_media/entities/user/user_entities.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';

export 'profile_settings_bloc.dart';
part 'profile_settings_event.dart';
part 'profile_settings_state.dart';

class ProfileSettingsBloc extends Bloc<ProfileSettingsEvent, ProfileSettingsState> {
  ProfileSettingsBloc(this._authRepo) : super(const ProfileSettingsState()) {
    on<DisplayProfileInformation>(_displayProfileInformation);
    on<StartEditingUsername>(_startEditingUsername);
    on<StopEditingUsername>(_stopEditingUsername);
    on<StartEditingEmail>(_startEditingEmail);
    on<StopEditingEmail>(_stopEditingEmail);
    on<StartEditingPassword>(_startEditingPassword);
    on<StopEditingPassword>(_stopEditingPassword);
  }

  final AuthenticationRepository _authRepo;

  void _startEditingPassword(StartEditingPassword event, Emitter<ProfileSettingsState> emit) {
    emit(state.copyWith(
      editingPassword: true
    ));
  }

  void _stopEditingPassword(StopEditingPassword event, Emitter<ProfileSettingsState> emit) {
    emit(state.copyWith(
      editingPassword: false
    ));
  }

  void _stopEditingEmail(StopEditingEmail event, Emitter<ProfileSettingsState> emit) {
    emit(state.copyWith(
      editingEmail: false
    ));
  }

  void _startEditingEmail(StartEditingEmail event, Emitter<ProfileSettingsState> emit) {
    emit(state.copyWith(
      editingEmail: true
    ));
  }

  void _stopEditingUsername(StopEditingUsername event, Emitter<ProfileSettingsState> emit) {
    emit(state.copyWith(
      editingUsername: false
    ));
  }

  void _startEditingUsername(StartEditingUsername event, Emitter<ProfileSettingsState> emit) {
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