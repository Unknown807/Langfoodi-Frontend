part of 'add_group_widgets.dart';

class UserSearchInput extends StatelessWidget {
  const UserSearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddGroupBloc, AddGroupState>(
      builder: (context, state) {
        return SearchInput(
          textController: state.searchTextController,
          inputLabel: "Username or Handle",
          onSubmit: (_) {
            if (state.searchLoading) return;
            context.read<AddGroupBloc>().add(const SearchForUsers());
          },
          onTap: () {
            if (state.searchLoading) return;
            context.read<AddGroupBloc>().add(const SearchForUsers());
          },
        );
      },
    );
  }
}