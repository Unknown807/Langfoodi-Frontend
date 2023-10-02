import 'package:flutter/material.dart';
import 'package:recipe_social_media/widgets/shared_widgets.dart';

class ProfileSettingsPage extends StatelessWidget {
  const ProfileSettingsPage({super.key});
//TODO: Add profile image, back button
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Profile settings")),
      body: ListView(
          children:  const [
            CustomMenuItem(titleText:"Username",subtitleText:"Cool guy"),
            CustomMenuItem(titleText:"Email",subtitleText:"me@cooldude.com"),
            CustomMenuItem(titleText:"Bio",subtitleText:"I like cooking"),
            CustomMenuItem(titleText:"Password",subtitleText:null)
          ]
      ),
    );
  }
}
