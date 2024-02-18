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
          : Text("users list here");
      },
    );
  }
}