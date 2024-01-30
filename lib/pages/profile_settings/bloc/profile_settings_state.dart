part of 'profile_settings_bloc.dart';

class ProfileSettingsState extends Equatable {
  const ProfileSettingsState({
    this.handler = "",
    this.username = "",
    this.email = "",
    this.thumbnailId = "",
    this.creationDate = ""
  });

  final String handler;
  final String username;
  final String email;
  final String thumbnailId;
  final String creationDate;

  @override
  List<Object> get props => [
    handler, username, email, thumbnailId,
    creationDate
  ];

  ProfileSettingsState copyWith({
    String? handler,
    String? username,
    String? email,
    String? thumbnailId,
    String? creationDate
  }) {
    return ProfileSettingsState(
      handler: handler ?? this.handler,
      username: username ?? this.username,
      email: email ?? this.email,
      thumbnailId: thumbnailId ?? this.thumbnailId,
      creationDate: creationDate ?? this.creationDate
    );
  }
}