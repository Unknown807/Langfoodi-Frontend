part of 'profile_settings_widgets.dart';

class ProfileThumbnailPicker extends StatelessWidget {
  const ProfileThumbnailPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileSettingsBloc, ProfileSettingsState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            final selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
            if (selectedImage != null && context.mounted) {
              // TODO: pick image event
              print(selectedImage.path);
            }
          },
          child: state.thumbnailId == null
            ? const Center(
                child: CustomCircleAvatar(
                  avatarIcon: Icons.person,
                  avatarIconSize: 120,
                  circleRadiusSize: 80,
                )
            )
            : SizedBox(
                height: 160,
                width: 160,
                child: ClipOval(
                  child: context.read<ImageBuilder>().decideOnAndDisplayImage(
                    imageUrl: state.thumbnailId!,
                    transformationType: ImageTransformationType.standard,
                    errorBuilder: (context, obj1, obj2) {
                      return CustomIconTile(
                        icon: Icons.error,
                        borderStrokeWidth: 4,
                        borderRadius: 100,
                        iconColor: Theme.of(context).colorScheme.error,
                        tileColor: Theme.of(context).colorScheme.error,
                      );
                    },
                  )
                )
              )
        );
      },
    );
  }
}