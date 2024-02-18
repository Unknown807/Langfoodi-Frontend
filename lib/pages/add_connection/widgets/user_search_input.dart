part of 'add_connection_widgets.dart';

class UserSearchInput extends StatelessWidget {
  const UserSearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddConnectionBloc, AddConnectionState>(
      builder: (context, state) {
        return FormInput(
          textController: state.searchTextController,
          outerPadding: const EdgeInsets.all(20),
          innerPadding: const EdgeInsets.symmetric(horizontal: 10),
          labelText: "Username or Handle",
          boxDecorationType: FormInputBoxDecorationType.textArea,
          fontSize: 18,
          eventFunc: (value) {print(value);},
        );
      },
    );
  }
}