part of 'profile_settings_widgets.dart';

// TODO: to be fully implemented in the next ticket, but can remain for now
class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileSettingsBloc, ProfileSettingsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 5),
          child: state.editingPassword
            ? const SizedBox.shrink()
            : Center(
                child: CustomTextButton(
                  text: "Change Password",
                  eventFunc: () {},
                ),
              )
        );
      },
    );
  }
}