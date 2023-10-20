import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_social_media/widgets/shared_widgets.dart';

import '../../repositories/navigation/navigation_repo.dart';

class ProfileSettingsPage extends StatelessWidget {
  const ProfileSettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: AppBar(
            automaticallyImplyLeading: false,
            title: const Text("Edit profile"),
            backgroundColor: Colors.green,
            leading: GestureDetector(
              onTap: () => context.read<NavigationRepository>().goTo(context, "/home", RouteType.backLink),
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
