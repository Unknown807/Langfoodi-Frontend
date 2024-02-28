import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:recipe_social_media/app/app.dart';
import 'package:recipe_social_media/forms/bloc/base_form.dart';
import 'package:recipe_social_media/pages/profile_settings/bloc/profile_settings_bloc.dart';
import 'package:recipe_social_media/pages/profile_settings/bloc/profile_settings_form_bloc.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/navigation/navigation_repo.dart';
import 'package:recipe_social_media/utilities/utilities.dart';
import 'package:recipe_social_media/widgets/shared_widgets.dart';

import 'widgets/profile_settings_widgets.dart';

class ProfileSettingsPage extends StatelessWidget implements PageLander {
  const ProfileSettingsPage({super.key});

  @override
  void onLanding(BuildContext context) {
    BlocProvider.of<ProfileSettingsBloc>(context)
        .add(const DisplayProfileInformation());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileSettingsFormBloc, InputState>(
      listener: (context, state) {
        if (state.formStatus.isSuccess) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) => BlocProvider<ProfileSettingsBloc>.value(
              value: BlocProvider.of<ProfileSettingsBloc>(context),
              child: CustomAlertDialog(
                title: const Text("Success!"),
                content: const Text("Profile Updated"),
                leftButtonText: null,
                rightButtonCallback: () {
                  context
                    .read<ProfileSettingsBloc>()
                    .add(ResetProfile(
                      state.email.value,
                      state.password.value
                    ));

                  context
                    .read<ProfileSettingsFormBloc>()
                    .add(const ResetForm());
                }
              ),
            )
          );
        } else if (state.formStatus.isFailure && state.errorMessage.isNotEmpty) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) => BlocProvider<ProfileSettingsBloc>.value(
              value: BlocProvider.of<ProfileSettingsBloc>(context),
              child: CustomAlertDialog(
                title: const Text("Oops!"),
                content: Text(state.errorMessage),
                leftButtonText: null,
                rightButtonCallback: () => context
                  .read<ProfileSettingsFormBloc>()
                  .add(const ResetErrorMessage())
              )
            )
          );
        }
      },
      builder: (context, state) {
        final pageState = context.watch<ProfileSettingsBloc>().state;
        return state.formStatus.isInProgress || pageState.pageLoading
          ? const Scaffold(body: Center(child: CircularProgressIndicator()))
          : Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(56),
                child: AppBar(
                  automaticallyImplyLeading: false,
                  leading: IconButton(
                    icon: Icon(
                      Theme.of(context).colorScheme.brightness == Brightness.dark
                        ? Icons.sunny
                        : Icons.nightlight,
                      color: Theme.of(context).colorScheme.onBackground.withAlpha(180),
                    ),
                    onPressed: () => context
                      .read<AppBloc>()
                      .add(const ChangeAppTheme())
                  ),
                  title: const Text("My Profile"),
                  backgroundColor: Theme.of(context).primaryColor,
                  actions: [
                    IconButton(
                      icon: Icon(
                        Icons.logout_rounded,
                        color: Theme.of(context).colorScheme.onBackground.withAlpha(180),
                      ),
                      onPressed: () => showDialog(
                        context: context,
                        builder: (_) => CustomAlertDialog(
                          title: const Text("Logout?"),
                          content: const Text("Are you sure you want to logout?"),
                          dismissOnRightButton: false,
                          rightButtonText: "Yes",
                          rightButtonCallback: () {
                            context
                              .read<AuthenticationRepository>()
                              .logOut();

                            context
                              .read<NavigationRepository>()
                              .goTo(context, "/login", routeType: RouteType.onlyThis);
                          },
                        )
                      )
                    )
                  ],
                )
              ),
              body: SingleChildScrollView(
                reverse: true,
                child: Column(
                  children: [
                    const CreationDateField(),
                    const ProfileThumbnailPicker(),
                    const HandleField(),
                    const UsernameInput(),
                    const EmailInput(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Divider(color: Theme.of(context).colorScheme.tertiary)
                    ),
                    const PasswordInput(),
                  ],
                ),
              )
        );
      }
    );
  }
}
