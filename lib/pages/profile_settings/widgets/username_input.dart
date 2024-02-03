part of 'profile_settings_widgets.dart';

// TODO: to be fully implemented in the next ticket, but can remain for now
class UsernameInput extends StatelessWidget {
  const UsernameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileSettingsBloc, ProfileSettingsState>(
      buildWhen: (p, c) =>
        p.editingUsername != c.editingUsername
        || p.username != c.username,
      builder: (context, state) {
        return state.editingUsername
          ? BlocBuilder<ProfileSettingsFormBloc, InputState>(
              builder: (context, formState) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20, right: 15),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: FormInput(
                          outerPadding: const EdgeInsets.only(right: 10),
                          boxDecorationType: FormInputBoxDecorationType.textArea,
                          errorText: FormValidationError.getErrorMessage(formState.userName.displayError),
                          hintText: state.username,
                          eventFunc: (username) => context
                            .read<ProfileSettingsFormBloc>()
                            .add(UserNameChanged(username))
                        ),
                      ),
                      IconButton(
                        iconSize: 30,
                        splashRadius: 20,
                        icon: const Icon(Icons.cancel_rounded),
                        color: Theme.of(context).colorScheme.inversePrimary,
                        onPressed: () {
                          context.read<ProfileSettingsFormBloc>().add(const UserNameChanged(""));
                          context.read<ProfileSettingsBloc>().add(const StopEditingUsername());
                        },
                      ),
                      IconButton(
                        iconSize: 30,
                        splashRadius: 20,
                        icon: const Icon(Icons.check_circle),
                        color: Theme.of(context).colorScheme.primary,
                        onPressed: () => showDialog(
                          context: context,
                          builder: (_) => BlocProvider<ProfileSettingsFormBloc>.value(
                            value: BlocProvider.of<ProfileSettingsFormBloc>(context),
                            child: CustomAlertDialog(
                              title: const Text("Update Username"),
                              content: const Text("Are you sure you want to update your username?"),
                              rightButtonCallback: () => context
                                .read<ProfileSettingsFormBloc>()
                                .add(const UpdateUsername())
                            ),
                          ),

                        ),
                      )
                    ],
                  )
                );
              },
            )
          : ReadonlyProfileTile(
              titleText: "Username",
              subtitleText: state.username,
              eventFunc: () => context
                .read<ProfileSettingsBloc>()
                .add(const StartEditingUsername())
            );
      },
    );
  }
}