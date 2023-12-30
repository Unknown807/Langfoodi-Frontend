import 'package:flutter/material.dart';

class NavigatorScreenFake extends StatelessWidget {
  const NavigatorScreenFake({
    super.key,
    required this.targetScreen,
    required this.arguments
  });

  final Widget targetScreen;
  final Object arguments;

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((value) {
      Navigator.push(context,
        MaterialPageRoute(
          builder: (BuildContext context) => targetScreen,
          settings: RouteSettings(
            arguments: arguments
          )
        ));
    });

    return Container();
  }
}