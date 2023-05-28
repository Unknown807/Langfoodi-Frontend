import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:recipe_social_media/register/register_page.dart';
import 'package:recipe_social_media/services/auth_service.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loginBtnFocus = false;
  bool loginAttemptErr = false;

  // Used for validating each sign up field before submitting to server
  final nameAndEmailController = TextEditingController();
  final passwordController = TextEditingController();

  void gotoHomePage() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MyHomePage(title: "Home Page")));
  }

  void gotoRegisterPage() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const RegisterPage()));
  }

  void attemptLogin() async {
    setState(() {
      loginAttemptErr = false;
      loginBtnFocus = !loginBtnFocus;
      Timer(const Duration(milliseconds: 300), () {
        setState(() {
          loginBtnFocus = !loginBtnFocus;
        });
      });
    });

    Response resp = await AuthService.attemptLogin(nameAndEmailController.text, passwordController.text);
    if (resp.statusCode == 200) {
      AuthService.setToken(jsonDecode(resp.body)["token"]);
      gotoHomePage();
    } else {
      setState(() {
        loginAttemptErr = true;
      });
    }
  }

  @override
  void dispose() {
    nameAndEmailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: <Widget>[
                Container(
                  height: 350,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/background.png"),
                        fit: BoxFit.fill),
                  ),
                  child: const Stack(
                    children: <Widget>[
                      Positioned(
                        child: Center(
                          child: Text("Welcome",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(children: <Widget>[
                      Text(loginAttemptErr ? "Invalid Login Details" : "",
                          style: const TextStyle(
                            color: Color.fromRGBO(244, 113, 116, 1),
                          )),
                      const SizedBox(height: 5),
                      Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(143, 148, 251, .2),
                                    blurRadius: 20.0,
                                    offset: Offset(0, 10))
                              ]),
                          child: Column(children: <Widget>[
                            Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade100))),
                                child: TextField(
                                  controller: nameAndEmailController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Username or Email",
                                      hintStyle: TextStyle(
                                          color: Colors.grey.shade400)),
                                )),
                            Container(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                    controller: passwordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle: TextStyle(
                                            color: Colors.grey.shade400))))
                          ])),
                      Row(
                        children: <Widget>[
                          const Spacer(),
                          TextButton(
                              style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                      const Color.fromRGBO(143, 148, 251, .5))),
                              onPressed: () {},
                              child: const Text("Forgot Password?",
                                  style: TextStyle(
                                    color: Color.fromRGBO(105, 110, 253, 1),
                                  )))
                        ],
                      ),
                      GestureDetector(
                          onTap: attemptLogin,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(colors: [
                                  Color.fromRGBO(
                                      143, 148, 251, loginBtnFocus ? .5 : 1),
                                  Color.fromRGBO(
                                      143, 148, 251, loginBtnFocus ? .1 : .5),
                                ])),
                            child: const Center(
                                child: Text("Login",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ))),
                          )),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text("Don't have an account?    ",
                              style: TextStyle(
                                color: Color.fromRGBO(143, 148, 251, 1),
                              )),
                          TextButton(
                              style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                      const Color.fromRGBO(143, 148, 251, .5))),
                              onPressed: gotoRegisterPage,
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: Color.fromRGBO(105, 110, 253, 1),
                                    fontSize: 16),
                              )),
                        ],
                      ),
                    ]))
              ],
            ),
          ),
        ));
  }
}
