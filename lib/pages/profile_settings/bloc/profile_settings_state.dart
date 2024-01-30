part of 'profile_settings_bloc.dart';

class ProfileSettingsState extends Equatable {
  const ProfileSettingsState({
    this.handler = "",
    this.username = "",
    this.email = "",
    this.thumbnailId = "",
  });

  final String handler;
  final String username;
  final String email;
  final String thumbnailId;

  @override
  List<Object> get props => [
    handler, username, email, thumbnailId
  ];

  ProfileSettingsState copyWith({
    String? handler,
    String? username,
    String? email,
    String? thumbnailId
  }) {
    return ProfileSettingsState(
      handler: handler ?? this.handler,
      username: username ?? this.username,
      email: email ?? this.email,
      thumbnailId: thumbnailId ?? this.thumbnailId
    );
  }
}