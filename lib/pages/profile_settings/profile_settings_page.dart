import 'package:flutter/material.dart';
import 'package:recipe_social_media/widgets/shared_widgets.dart';
part 'widgets/top_app_bar.dart';

class ProfileSettingsPage extends StatelessWidget {
  const ProfileSettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: TopAppBar(title: "Edit profile")),
      body: Column(children:<Widget>[
        const CustomAvatar(),
        Expanded(child:ListView(
          children:  const [
            CustomItemTile(titleText:"Username",subtitleText:"Cool guy"),
            CustomItemTile(titleText:"Bio",subtitleText:"I like cooking"),
            CustomItemTile(titleText:"Email",subtitleText:"me@cooldude.com"),
            CustomItemTile(titleText:"Password",subtitleText:null)
          ]
      ))]),
    );
  }
}
