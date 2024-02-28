part of 'add_connection_widgets.dart';

class UserSearchInput extends StatelessWidget {
  const UserSearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddConnectionBloc, AddConnectionState>(
      builder: (context, state) {
        return SearchInput(
          textController: state.searchTextController,
          inputLabel: "Username or Handle",
          onSubmit: (_) {
            if (state.searchLoading) return;
            context.read<AddConnectionBloc>().add(const SearchForUsers());
          },
          onTap: () {
            if (state.searchLoading) return;
            context.read<AddConnectionBloc>().add(const SearchForUsers());
          },
        );
      },
    );
  }
}