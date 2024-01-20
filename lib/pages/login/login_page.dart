import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_social_media/pages/login/login_bloc.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/utilities/utilities.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
            reverse: true,
            child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(children: <Widget>[
                  Container(
                    key: const Key("loginPageBgImg"),
                    height: 350,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: context.read<ImageBuilder>().getAssetImage(
                          "assets/images/${Theme.of(context).brightness == Brightness.light ? "light": "dark"}_auth_bg.png"
                        )
                      ),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          child: Center(
                            child: Text("Welcome", style: Theme.of(context).textTheme.displayLarge),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: BlocProvider<LoginBloc>(
                        create: (_) => LoginBloc(
                          authRepo: context.read<AuthenticationRepository>(),
                          networkManager: context.read<NetworkManager>()
                        ),
                        child: const LoginForm(),
                      ))
                ]))));
  }
}
