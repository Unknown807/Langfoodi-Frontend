import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_social_media/app/app.dart';
import 'package:recipe_social_media/pages/profile_settings/bloc/profile_settings_bloc.dart';
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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("My Profile"),
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
            IconButton(
              icon: Icon(
                Theme.of(context).colorScheme.brightness == Brightness.dark
                  ? Icons.sunny
                  : Icons.nightlight,
                color: Theme.of(context).colorScheme.onBackground.withAlpha(180),
              ),
              onPressed: () => context
                .read<AppBloc>()
                .add(const ChangeAppTheme())
            )
          ],
        )
      ),
      body: const Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Center(
              child: CustomCircleAvatar(
                avatarIcon: Icons.person,
                avatarIconSize: 120,
                circleRadiusSize: 80,
              )
            ),
          ),
          UsernameInput(),
          HandleInput()
        ],
      ),
    );
  }
}
