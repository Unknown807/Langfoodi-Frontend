part of 'profile_settings_bloc.dart';

class ProfileSettingsState extends Equatable {
  const ProfileSettingsState({
    this.handler = "",
    this.username = "",
    this.email = "",
    this.creationDate = "",
    this.editingUsername = false,
    this.editingEmail = false,
    this.editingPassword = false,
    this.currentThumbnailId,
    this.newThumbnailPath
  });

  final String handler;
  final String username;
  final String email;
  final String? currentThumbnailId;
  final String? newThumbnailPath;
  final String creationDate;
  final bool editingUsername;
  final bool editingEmail;
  final bool editingPassword;

  @override
  List<Object?> get props => [
    handler, username, email,
    currentThumbnailId, newThumbnailPath,
    creationDate, editingUsername,
    editingEmail, editingPassword
  ];

  ProfileSettingsState copyWith({
    String? handler,
    String? username,
    String? email,
    String? currentThumbnailId,
    String? newThumbnailPath,
    String? creationDate,
    bool? editingUsername,
    bool? editingEmail,
    bool? editingPassword
  }) {
    return ProfileSettingsState(
      handler: handler ?? this.handler,
      username: username ?? this.username,
      email: email ?? this.email,
      currentThumbnailId: currentThumbnailId ?? this.currentThumbnailId,
      newThumbnailPath: newThumbnailPath,
      creationDate: creationDate ?? this.creationDate,
      editingUsername: editingUsername ?? this.editingUsername,
      editingEmail: editingEmail ?? this.editingEmail,
      editingPassword: editingPassword ?? this.editingPassword
    );
  }
}