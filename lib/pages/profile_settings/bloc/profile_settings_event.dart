part of 'profile_settings_bloc.dart';

@immutable
sealed class ProfileSettingsEvent extends Equatable {
  const ProfileSettingsEvent();

  @override
  List<Object> get props => [];
}

final class DisplayProfileInformation extends ProfileSettingsEvent {
  const DisplayProfileInformation();
}

final class ResetProfile extends ProfileSettingsEvent {
  const ResetProfile(this.newEmail, this.newPassword);

  final String newEmail;
  final String newPassword;

  @override
  get props => [newEmail, newPassword];
}

final class StartEditingProfileImage extends ProfileSettingsEvent {
  const StartEditingProfileImage(this.imagePath);

  final String imagePath;

  @override
  get props => [imagePath];
}

final class StopEditingProfileImage extends ProfileSettingsEvent {
  const StopEditingProfileImage();
}

final class StartEditingPassword extends ProfileSettingsEvent {
  const StartEditingPassword();
}

final class StopEditingPassword extends ProfileSettingsEvent {
  const StopEditingPassword();
}

final class StartEditingEmail extends ProfileSettingsEvent {
  const StartEditingEmail();
}

final class StopEditingEmail extends ProfileSettingsEvent {
  const StopEditingEmail();
}

final class StartEditingUsername extends ProfileSettingsEvent {
  const StartEditingUsername();
}

final class StopEditingUsername extends ProfileSettingsEvent {
  const StopEditingUsername();
}
