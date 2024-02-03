part of 'profile_settings_widgets.dart';

class HandleField extends StatelessWidget {
  const HandleField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileSettingsBloc, ProfileSettingsState>(
      buildWhen: (p, c) =>
        p.editingHandler != c.editingHandler
        || p.handler != c.handler,
      builder: (context, state) {
        return ReadonlyProfileTile(
          titleText: "Handle",
          subtitleText: state.handler,
          eventFunc: () {},
          editable: false,
        );
      },
    );
  }
}