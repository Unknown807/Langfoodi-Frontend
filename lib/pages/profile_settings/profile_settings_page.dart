import 'package:flutter/material.dart';
import 'package:recipe_social_media/widgets/shared_widgets.dart';

class ProfileSettingsPage extends StatelessWidget {
  const ProfileSettingsPage({super.key});
//TODO: Add profile image, back button, edit bio text box with character limit
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Profile settings")),
      body: ListView(
          children:  [
            CustomMenuItem(titleText:"Username",subtitleText:"Cool guy"),
            CustomMenuItem(titleText:"Email",subtitleText:"me@cooldude.com"),
            CustomMenuItem(titleText:"Password",subtitleText:null)
          ]
      ),
    );
  }
}
