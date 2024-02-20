part of 'add_group_widgets.dart';

class SelectedUserList extends StatelessWidget {
  const SelectedUserList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddGroupBloc, AddGroupState>(
      builder: (context, state) {
        return AnimatedSize(
          curve: Curves.fastEaseInToSlowEaseOut,
          duration: const Duration(milliseconds: 300),
          child: Padding(
            padding: state.selectedUsers.isEmpty
              ? EdgeInsets.zero
              : const EdgeInsets.fromLTRB(15, 20, 20, 0),
            child: SizedBox(
              height: state.selectedUsersBoxHeight,
              width: double.infinity,
              child: ListView.separated(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                itemCount: state.selectedUsers.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 15);
                },
                itemBuilder: (context, index) {
                  final user = state.selectedUsers[index];
                  return FadeIn(
                    duration: const Duration(milliseconds: 350),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            user.profileImageId != null
                              ? SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: ClipOval(
                                    child: context.read<ImageBuilder>().displayCloudinaryImage(
                                      imageUrl: user.profileImageId!,
                                      errorBuilder: (err, ob1, ob2) {
                                        return CustomIconTile(
                                          icon: Icons.error,
                                          borderStrokeWidth: 4,
                                          borderRadius: 100,
                                          iconColor: Theme.of(context).colorScheme.error,
                                          tileColor: Theme.of(context).colorScheme.error,
                                        );
                                      }
                                    ),
                                  ),
                                )
                              : const CustomCircleAvatar(
                                  avatarIcon: Icons.person_rounded,
                                  avatarIconSize: 40,
                                  circleRadiusSize: 25,
                                ),
                            Text(user.username)
                          ],
                        ),

                        Positioned(
                          bottom: 45,
                          right: 20,
                          child: IconButton(
                            splashRadius: 15,
                            color: Colors.white,
                            icon: Icon(
                              Icons.cancel_rounded,
                              color: Theme.of(context).colorScheme.inversePrimary,
                              size: 20,
                            ),
                            onPressed: () => context
                              .read<AddGroupBloc>()
                              .add(DeselectUser(user.id))
                          ),
                        ),
                      ],
                    )
                  );
                },
              )
            )
          ),
        );
      }
    );
  }
}