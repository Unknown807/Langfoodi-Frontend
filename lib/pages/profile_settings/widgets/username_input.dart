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
                return FormInput(
                  boxDecorationType: FormInputBoxDecorationType.textArea,
                  errorText: FormValidationError.getErrorMessage(formState.userName.displayError),
                  hintText: state.username,
                  eventFunc: (username) {
                    print("username changed");
                  },
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