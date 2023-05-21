import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:recipe_social_media/pages/home_page.dart';
import 'package:recipe_social_media/services/auth_service.dart';
import 'package:recipe_social_media/services/validation_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool registerBtnFocus = false;
  bool registerAttemptErr = false;

  // Used for validating each sign up field before submitting to server
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String? emailErrTxt;
  String? userNameErrTxt;
  String? passwordErrTxt;
  String? confirmPasswordErrTxt;

  void gotoHomePage() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MyHomePage(title: "Home Page")));
  }

  void validateEmail() {
    setState(() {
      String text = emailController.text;
      bool validEmail = ValidationService.isValidEmail(text);

      emailErrTxt = validEmail || text.isEmpty ? null : "Invalid email address";
    });
  }

  void validateUserName() {
    setState(() {
      String text = userNameController.text;
      bool validUserName = ValidationService.isValidUserName(text);

      userNameErrTxt = validUserName || text.isEmpty
          ? null
          : "Needs 3+ length & only letters/numbers";
    });
  }

  void matchingPasswords() {
    if (passwordController.text == confirmPasswordController.text) {
      passwordErrTxt = null;
      confirmPasswordErrTxt = null;
    } else {
      passwordErrTxt = "Passwords must match";
      confirmPasswordErrTxt = "Passwords must match";
    }
  }

  void validatePasswords() {
    setState(() {
      bool validPassword =
          ValidationService.isValidPassword(passwordController.text);
      bool validConfirmPassword =
          ValidationService.isValidPassword(confirmPasswordController.text);

      if (validPassword && validConfirmPassword) {
        matchingPasswords();
      } else {
        String errMsg =
            "Needs 8+ length & one of each character - upper case, lower case, number & special";

        passwordErrTxt =
            validPassword || passwordController.text.isEmpty ? null : errMsg;

        confirmPasswordErrTxt =
            validConfirmPassword || confirmPasswordController.text.isEmpty
                ? null
                : errMsg;
      }
    });
  }

  void validateAllFields() async {
    setState(() {
      registerAttemptErr = false;
      registerBtnFocus = !registerBtnFocus;
      Timer(const Duration(milliseconds: 300), () {
        setState(() {
          registerBtnFocus = !registerBtnFocus;
        });
      });
    });

    bool validFields = [
          emailErrTxt,
          userNameErrTxt,
          passwordErrTxt,
          confirmPasswordErrTxt
        ].every((txt) => txt == null) &&
        [
          emailController.text,
          userNameController.text,
          passwordController.text,
          confirmPasswordController.text
        ].every((txt) => txt.isNotEmpty);

    if (validFields) {
      Response resp = await AuthService.attemptRegister(userNameController.text, emailController.text,
              passwordController.text);

      if (resp.statusCode == 200) {
        AuthService.setToken(jsonDecode(resp.body)["token"]);
        gotoHomePage();
      } else {
        setState(() {
          registerAttemptErr = true;
        });
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    userNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
                      Text(registerAttemptErr ? "Username/Email Already Exists" : "",
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
                                  controller: userNameController,
                                  onChanged: (_) {
                                    validateUserName();
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      errorText: userNameErrTxt,
                                      hintText: "Username",
                                      hintStyle: TextStyle(
                                          color: Colors.grey.shade400)),
                                )),
                            Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade100))),
                                child: TextField(
                                  controller: emailController,
                                  onChanged: (_) {
                                    validateEmail();
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      errorText: emailErrTxt,
                                      hintText: "Email",
                                      hintStyle: TextStyle(
                                          color: Colors.grey.shade400)),
                                )),
                            Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade100))),
                                child: TextField(
                                    onChanged: (_) {
                                      validatePasswords();
                                    },
                                    controller: passwordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        errorText: passwordErrTxt,
                                        hintText: "Password",
                                        hintStyle: TextStyle(
                                            color: Colors.grey.shade400)))),
                            Container(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                    onChanged: (_) {
                                      validatePasswords();
                                    },
                                    controller: confirmPasswordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        errorText: confirmPasswordErrTxt,
                                        hintText: "Confirm Password",
                                        hintStyle: TextStyle(
                                            color: Colors.grey.shade400))))
                          ])),
                      const SizedBox(height: 20),
                      GestureDetector(
                          onTap: validateAllFields,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(colors: [
                                  Color.fromRGBO(
                                      143, 148, 251, registerBtnFocus ? .5 : 1),
                                  Color.fromRGBO(143, 148, 251,
                                      registerBtnFocus ? .1 : .5),
                                ])),
                            child: const Center(
                                child: Text("Sign Up",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ))),
                          )),
                    ]))
              ],
            ),
          ),
        ));
  }
}
