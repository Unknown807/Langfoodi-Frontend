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
