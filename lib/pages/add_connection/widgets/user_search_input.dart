part of 'add_connection_widgets.dart';

class UserSearchInput extends StatelessWidget {
  const UserSearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddConnectionBloc, AddConnectionState>(
      builder: (context, state) {
        return Row(
          children: <Widget>[
            Flexible(
              child: FormInput(
                textController: state.searchTextController,
                outerPadding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
                innerPadding: const EdgeInsets.symmetric(horizontal: 10),
                labelText: "Username or Handle",
                boxDecorationType: FormInputBoxDecorationType.textArea,
                fontSize: 18,
                eventFunc: (_) {},
                onSubmittedEventFunc: (_) => context
                  .read<AddConnectionBloc>()
                  .add(const SearchForUsers())
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: ClipOval(
                child: Material(
                  color: Theme.of(context).colorScheme.primary, // Button color
                  child: InkWell(
                    splashColor: Theme.of(context).colorScheme.secondary, // Splash color
                    child: SizedBox(
                      width: 46,
                      height: 46,
                      child: Icon(
                        Icons.search_rounded,
                        color: Theme.of(context).colorScheme.onPrimary,
                      )
                    ),
                    onTap: () => context
                      .read<AddConnectionBloc>()
                      .add(const SearchForUsers())
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}