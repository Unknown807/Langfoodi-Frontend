part of 'add_group_widgets.dart';

class SearchedUserList extends StatelessWidget {
  const SearchedUserList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddGroupBloc, AddGroupState>(
      builder: (context, state) {
        return UserList(
          noUsersFoundFlag: state.prevSearchTerm.isNotEmpty && state.searchedUsers.isEmpty,
          listLoadingFlag: state.searchLoading,
          users: state.searchedUsers,
          onTap: (UserAccount user) => context
            .read<AddGroupBloc>()
            .add(SelectUser(user))
        );
      },
    );
  }
}