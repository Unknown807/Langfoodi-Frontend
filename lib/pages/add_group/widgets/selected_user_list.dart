part of 'add_group_widgets.dart';

class SelectedUserList extends StatelessWidget {
  const SelectedUserList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddGroupBloc, AddGroupState>(
      builder: (context, state) {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: state.selectedUsers.length,
          itemBuilder: (context, index) {
            final user = state.selectedUsers[index];
            return Text(user.username);
          },
        );
      }
    );
  }
}