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
    on<StartEditingProfileImage>(_startEditingProfileImage);
    on<StopEditingProfileImage>(_stopEditingProfileImage);
    on<ResetProfile>(_resetProfile);
  }

  final AuthenticationRepository _authRepo;

  void _stopEditingProfileImage(StopEditingProfileImage event, Emitter<ProfileSettingsState> emit) {
    emit(state.copyWith(
      newThumbnailPath: null
    ));
  }

  void _startEditingProfileImage(StartEditingProfileImage event, Emitter<ProfileSettingsState> emit) {
    emit(state.copyWith(
      newThumbnailPath: event.imagePath
    ));
  }

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

  void _resetProfile(ResetProfile event, Emitter<ProfileSettingsState> emit) async {
    String newEmail = event.newEmail;
    String newPassword = event.newPassword;

    emit(state.copyWith(pageLoading: true));
    User user = await _authRepo.currentUser;
    await _authRepo.loginWithHandlerOrEmail(
      newEmail.isEmpty ? user.email : newEmail,
      newPassword.isEmpty ? user.password : newPassword
    );
    _getProfileInformation();
  }

  void _displayProfileInformation(DisplayProfileInformation event, Emitter<ProfileSettingsState> emit) async {
    _getProfileInformation();
  }

  void _getProfileInformation() async {
    User user = await _authRepo.currentUser;
    emit(state.copyWith(
      creationDate: DateFormat('dd-MM-yyyy').format(user.creationDate),
      handler: user.handler,
      username: user.username,
      email: user.email,
      currentThumbnailId: user.profileImageId,
      editingPassword: false,
      editingEmail: false,
      editingUsername: false,
      newThumbnailPath: null,
      pageLoading: false
    ));
  }
}