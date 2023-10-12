import 'package:flutter/material.dart';
import 'package:recipe_social_media/widgets/shared_widgets.dart';

class ProfileSettingsPage extends StatelessWidget {
  const ProfileSettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: AppBar(
            automaticallyImplyLeading: false,
            title: Text("Edit profile"),
            backgroundColor: Colors.green,
            leading: GestureDetector(
              onTap: () {Navigator.pop(context);},
              child: const Icon(
                Icons.arrow_back,
              ),
            )
            ,
          )),
      body: Column(children:<Widget>[
        const Padding(padding:EdgeInsets.all(16.0),
            child:CustomAvatar(size:70)),
        Expanded(child:ListView(
          children:  const [
            CustomItemTile(titleText:"Username",subtitleText:"Cool Guy"),
            CustomItemTile(titleText:"Handle",subtitleText:"@realcoolguy"),
            CustomItemTile(titleText:"Bio",subtitleText:"I like cooking"),
            CustomItemTile(titleText:"Email",subtitleText:"me@cooldude.com"),
            CustomItemTile(titleText:"Password",subtitleText:null),
          ]
      ))]),
    );
  }
}
