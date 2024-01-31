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
