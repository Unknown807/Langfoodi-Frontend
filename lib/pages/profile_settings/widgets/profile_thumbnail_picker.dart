part of 'profile_settings_widgets.dart';

class ProfileThumbnailPicker extends StatelessWidget {
  const ProfileThumbnailPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileSettingsBloc, ProfileSettingsState>(
      builder: (context, state) {
        return Column(
          children: <Widget>[
            GestureDetector(
              onTap: () async {
                final selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                if (selectedImage != null && context.mounted) {
                  context
                    .read<ProfileSettingsBloc>()
                    .add(StartEditingProfileImage(selectedImage.path));
                }
              },
              child: state.currentThumbnailId == null && state.newThumbnailPath.isEmpty
                ? const Center(
                    child: CustomCircleAvatar(
                      avatarIcon: Icons.person,
                      avatarIconSize: 120,
                      circleRadiusSize: 80
                    )
                  )
                : SizedBox(
                    height: 160,
                    width: 160,
                    child: ClipOval(
                      child: context.read<ImageBuilder>().decideOnAndDisplayImage(
                        imageUrl: state.newThumbnailPath.isNotEmpty ? state.newThumbnailPath : state.currentThumbnailId!,
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
            ),
            if (state.newThumbnailPath.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  EditFieldCancelButton(
                    onPressed: () => context
                      .read<ProfileSettingsBloc>()
                      .add(const StopEditingProfileImage())
                  ),
                  EditFieldSubmitButton(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (_) => BlocProvider<ProfileSettingsFormBloc>.value(
                        value: BlocProvider.of<ProfileSettingsFormBloc>(context),
                        child: CustomAlertDialog(
                          title: const Text("Update Profile Image"),
                          content: const Text("Are you sure you want to update your profile image?"),
                          rightButtonCallback: () => context
                            .read<ProfileSettingsFormBloc>()
                            .add(UpdateProfileImage(
                              state.newThumbnailPath,
                              state.currentThumbnailId
                            ))
                        ),
                      )
                    ),
                  )
                ],
              )
          ],
        );
      },
    );
  }
}