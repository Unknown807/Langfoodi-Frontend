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
          ? const SizedBox.shrink()
          : ReadonlyProfileTile(
              titleText: "Username",
              subtitleText: state.username,
              eventFunc: () {},
            );
      },
    );
  }
}