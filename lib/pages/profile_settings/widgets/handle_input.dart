part of 'profile_settings_widgets.dart';

// TODO: to be fully implemented in the next ticket, but can remain for now
class HandleInput extends StatelessWidget {
  const HandleInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileSettingsBloc, ProfileSettingsState>(
      builder: (context, state) {
        return state.editingHandler
            ? const SizedBox.shrink()
            : ReadonlyProfileTile(
          titleText: "Handle",
          subtitleText: state.handler,
          eventFunc: () {},
        );
      },
    );
  }
}