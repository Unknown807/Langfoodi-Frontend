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
          child: !state.editingPassword
            ? Center(
                child: CustomTextButton(
                  text: "Change Password",
                  eventFunc: () => context
                    .read<ProfileSettingsBloc>()
                    .add(const StartEditingPassword())
                ),
              )
            : BlocBuilder<ProfileSettingsFormBloc, InputState>(
                builder: (context, formState) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        FormInput(
                          isConfidential: true,
                          outerPadding: const EdgeInsets.only(bottom: 10),
                          boxDecorationType: FormInputBoxDecorationType.textArea,
                          errorText: FormValidationError.getErrorMessage(formState.password.displayError),
                          hintText: "Password",
                          eventFunc: (password) => context
                              .read<ProfileSettingsFormBloc>()
                              .add(PasswordChanged(password)),
                        ),
                        FormInput(
                          isConfidential: true,
                          boxDecorationType: FormInputBoxDecorationType.textArea,
                          errorText: FormValidationError.getErrorMessage(formState.confirmedPassword.displayError),
                          hintText: "Confirm Password",
                          eventFunc: (confirmedPassword) => context
                            .read<ProfileSettingsFormBloc>()
                            .add(ConfirmedPasswordChanged(confirmedPassword))
                        ),
                        Row(
                          children: <Widget>[
                            const Spacer(),
                            EditFieldCancelButton(
                              onPressed: () {
                                context.read<ProfileSettingsFormBloc>().add(const PasswordChanged(""));
                                context.read<ProfileSettingsFormBloc>().add(const ConfirmedPasswordChanged(""));
                                context.read<ProfileSettingsBloc>().add(const StopEditingPassword());
                              },
                            ),
                            EditFieldSubmitButton(
                              onPressed: () => showDialog(
                                context: context,
                                builder: (_) => BlocProvider<ProfileSettingsFormBloc>.value(
                                  value: BlocProvider.of<ProfileSettingsFormBloc>(context),
                                  child: CustomAlertDialog(
                                    title: const Text("Update Password"),
                                    content: const Text("Are you sure you want to update your password?"),
                                    rightButtonCallback: () => context
                                      .read<ProfileSettingsFormBloc>()
                                      .add(const UpdatePassword())
                                  ),
                                )
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              )
        );
      },
    );
  }
}