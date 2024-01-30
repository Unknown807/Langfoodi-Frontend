part of 'profile_settings_bloc.dart';

class ProfileSettingsState extends Equatable {
  const ProfileSettingsState({
    this.handler = "",
    this.username = "",
    this.email = "",
    this.creationDate = "",
    this.editingHandler = false,
    this.editingUsername = false,
    this.editingEmail = false,
    this.editingPassword = false,
    this.thumbnailId,
  });

  final String handler;
  final String username;
  final String email;
  final String? thumbnailId;
  final String creationDate;
  final bool editingHandler;
  final bool editingUsername;
  final bool editingEmail;
  final bool editingPassword;

  @override
  List<Object?> get props => [
    handler, username, email, thumbnailId,
    creationDate, editingHandler, editingUsername,
    editingEmail, editingPassword
  ];

  ProfileSettingsState copyWith({
    String? handler,
    String? username,
    String? email,
    String? thumbnailId,
    String? creationDate,
    bool? editingHandler,
    bool? editingUsername,
    bool? editingEmail,
    bool? editingPassword
  }) {
    return ProfileSettingsState(
      handler: handler ?? this.handler,
      username: username ?? this.username,
      email: email ?? this.email,
      thumbnailId: thumbnailId ?? this.thumbnailId,
      creationDate: creationDate ?? this.creationDate,
      editingHandler: editingHandler ?? this.editingHandler,
      editingUsername: editingUsername ?? this.editingUsername,
      editingEmail: editingEmail ?? this.editingEmail,
      editingPassword: editingPassword ?? this.editingPassword
    );
  }
}