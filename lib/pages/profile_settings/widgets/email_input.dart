part of 'profile_settings_widgets.dart';

// TODO: to be fully implemented in the next ticket, but can remain for now
class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileSettingsBloc, ProfileSettingsState>(
      builder: (context, state) {
        return state.editingEmail
            ? const SizedBox.shrink()
            : ReadonlyProfileTile(
                titleText: "Email",
                subtitleText: state.email,
                eventFunc: () {},
              );
      },
    );
  }
}