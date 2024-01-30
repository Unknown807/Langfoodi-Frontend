part of 'profile_settings_widgets.dart';

class ProfileThumbnailPicker extends StatelessWidget {
  const ProfileThumbnailPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileSettingsBloc, ProfileSettingsState>(
      builder: (context, state) {
        return SizedBox.shrink();
      },
    );
  }
}