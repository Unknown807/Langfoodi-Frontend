part of 'profile_settings_form_bloc.dart';

final class UpdateProfileImage extends InputEvent {
  const UpdateProfileImage(this.imagePath, this.currentImageId);

  final String imagePath;
  final String? currentImageId;

  @override
  get props => [imagePath, currentImageId];
}

final class ResetErrorMessage extends InputEvent {
  const ResetErrorMessage();
}

final class ResetForm extends InputEvent {
  const ResetForm();
}

final class UpdateUsername extends InputEvent {
  const UpdateUsername();
}

final class UpdateEmail extends InputEvent {
  const UpdateEmail();
}

final class UpdatePassword extends InputEvent {
  const UpdatePassword();
}