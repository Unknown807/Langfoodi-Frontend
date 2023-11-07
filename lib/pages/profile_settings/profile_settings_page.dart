import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_social_media/repositories/navigation/navigation_repo.dart';
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
            title: const Text("Edit profile"),
            backgroundColor: Colors.green,
            leading: GestureDetector(
              onTap: () {
                context
                  .read<NavigationRepository>()
                  .goTo(context, "/home", routeType: RouteType.backLink);
              },
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
            CustomItemTile(
              titleWidget: Text("Username"),
              subtitleWidget: Text("Cool Guy"),
              trailingWidget: Text("Edit"),
            ),
            CustomItemTile(
              titleWidget: Text("Handle"),
              subtitleWidget: Text("@realcoolguy"),
              trailingWidget: Text("Edit"),
            ),
            CustomItemTile(
              titleWidget: Text("Bio"),
              subtitleWidget: Text("I like cooking"),
              trailingWidget: Text("Edit"),
            ),
            CustomItemTile(
              titleWidget: Text("Email"),
              subtitleWidget: Text("me@cooldude.com"),
              trailingWidget: Text("Edit"),
            ),
            CustomItemTile(
              titleWidget: Text("Password"),
              trailingWidget: Text("Edit"),
            )
          ]
      ))]),
    );
  }
}
