part of 'profile_settings_form_bloc.dart';

final class UpdateProfileImage extends InputEvent {
  const UpdateProfileImage(this.imagePath);

  final String imagePath;

  @override
  get props => [imagePath];
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