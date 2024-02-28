import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_social_media/pages/login/login_bloc.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/utilities/utilities.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Align(alignment:Alignment.bottomCenter,child:SingleChildScrollView(child:Column(children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 50),
                  child:Container(
                    key: const Key("loginPageBgImg"),
                    height:70,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: context.read<ImageBuilder>().getAssetImage(
                          "assets/images/hero_logo_${Theme.of(context).brightness == Brightness.light ? "light": "dark"}.png"
                        )
                      ),
                    ))),
                  ((Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: (BlocProvider<LoginBloc>(
                        create: (_) => LoginBloc(
                          authRepo: context.read<AuthenticationRepository>(),
                          networkManager: context.read<NetworkManager>()
                        ),
                        child: LoginForm(emailController: emailController, passwordController: passwordController),
                      ))))),
                ])))));
  }
}
