part of 'add_connection_widgets.dart';

class ConnectionUserList extends StatelessWidget {
  const ConnectionUserList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddConnectionBloc, AddConnectionState>(
      builder: (context, state) {
        return UserList(
          noUsersFoundFlag: state.prevSearchTerm.isNotEmpty && state.users.isEmpty,
          listLoadingFlag: state.searchLoading,
          users: state.users,
          onTap: (UserAccount user) => showDialog(
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
          )
        );
      },
    );
  }
}