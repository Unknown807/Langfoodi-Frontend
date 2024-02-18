part of 'add_connection_widgets.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddConnectionBloc, AddConnectionState>(
      builder: (context, state) {
        return const Text("user list");
      },
    );
  }
}