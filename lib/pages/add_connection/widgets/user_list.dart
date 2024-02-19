part of 'add_connection_widgets.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddConnectionBloc, AddConnectionState>(
      builder: (context, state) {
        return state.prevSearchTerm.isNotEmpty && state.users.isEmpty
          ? Container(
              padding: const EdgeInsets.all(20),
              child: Text("No Users Found",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground.withAlpha(180),
                  fontSize: 18
                ),
              )
            )
          : state.searchLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (BuildContext context, int index) {
                  final user = state.users[index];
                  return Padding(padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(40),
                      splashColor: Theme.of(context).colorScheme.background,
                      onTap: () => showDialog(
                        context: context,
                        builder: (_) => BlocProvider<AddConnectionBloc>.value(
                          value: BlocProvider.of<AddConnectionBloc>(context),
                          child: CustomAlertDialog(
                            title: const Text("Start Conversation"),
                            content: Text("Want to add ${user.username}?"),
                            rightButtonText: "Yes",
                            rightButtonCallback: () => context
                              .read<AddConnectionBloc>()
                              .add(CreateConversation(user.id))
                          ),
                        )
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          user.profileImageId != null
                            ? SizedBox(
                                height: 90,
                                width: 90,
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
                                avatarIconSize: 70,
                                circleRadiusSize: 45,
                              ),

                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15, right: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    user.username,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.onBackground,
                                      fontSize: 24,
                                    ),
                                  ),
                                  Text(
                                    user.handler,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.onBackground.withAlpha(180),
                                      fontSize: 18
                                    ),
                                  )
                                ],
                              )
                            )
                          )
                        ],
                    )
                  )
                );
              }
          );
      },
    );
  }
}