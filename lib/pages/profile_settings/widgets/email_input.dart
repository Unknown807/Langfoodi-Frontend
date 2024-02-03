part of 'profile_settings_widgets.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileSettingsBloc, ProfileSettingsState>(
      buildWhen: (p, c) =>
        p.editingEmail != c.editingEmail
        || p.email != c.email,
      builder: (context, state) {
        return !state.editingEmail
          ? ReadonlyProfileTile(
              titleText: "Email",
              subtitleText: state.email,
              eventFunc: () => context
                .read<ProfileSettingsBloc>()
                .add(const StartEditingEmail())
            )
          : BlocBuilder<ProfileSettingsFormBloc, InputState>(
              builder: (context, formState) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 15, 5),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: FormInput(
                          outerPadding: const EdgeInsets.only(right: 10),
                          boxDecorationType: FormInputBoxDecorationType.textArea,
                          errorText: FormValidationError.getErrorMessage(formState.email.displayError),
                          hintText: state.email,
                          eventFunc: (email) => context
                            .read<ProfileSettingsFormBloc>()
                            .add(EmailChanged(email))
                        ),
                      ),
                      EditFieldCancelButton(
                        onPressed: () {
                          context.read<ProfileSettingsFormBloc>().add(const EmailChanged(""));
                          context.read<ProfileSettingsBloc>().add(const StopEditingEmail());
                        },
                      ),
                      EditFieldSubmitButton(
                        onPressed: () => showDialog(
                          context: context,
                          builder: (_) => BlocProvider<ProfileSettingsFormBloc>.value(
                            value: BlocProvider.of<ProfileSettingsFormBloc>(context),
                            child: CustomAlertDialog(
                              title: const Text("Update Email"),
                              content: const Text("Are you sure you want to update your email?"),
                              rightButtonCallback: () => context
                                .read<ProfileSettingsFormBloc>()
                                .add(const UpdateEmail()),
                            ),
                          )
                        ),
                      )
                    ],
                  ),
                );
              },
            );
      },
    );
  }
}