part of 'add_group_widgets.dart';

class SelectedUsersCounter extends StatelessWidget {
  const SelectedUsersCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddGroupBloc, AddGroupState>(
      buildWhen: (p, c) => p.selectedUsers != c.selectedUsers,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 15, top: 10),
          child: Row(
            children: <Widget>[
              Text(
                "Members",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 24
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 2, 8, 0),
                child: ClipOval(
                  child: Container(
                    color: Theme.of(context).colorScheme.background.withAlpha(150),
                    width: 25,
                    height: 25,
                    child: Center(
                      child: Text(
                        "${state.selectedUsers.length}",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      )
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}