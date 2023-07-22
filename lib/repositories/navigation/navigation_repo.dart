import 'package:flutter/material.dart';
part 'route_types.dart';

class NavigationRepository {
  void goTo(BuildContext context, String routeName, [RouteType routeType = RouteType.normal]) {
    switch (routeType) {
      case RouteType.normal:
        _push(context, routeName);
        break;
      case RouteType.backLink:
        _pop(context);
        break;
      case RouteType.onlyThis:
        _pushAndRemoveAll(context, routeName);
        break;
    }
  }

  void _push(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  void _pop(BuildContext context) {
    Navigator.pop(context);
  }

  void _pushAndRemoveAll(BuildContext context, String routeName) {
    Navigator.of(context).pushNamedAndRemoveUntil(routeName, (Route<dynamic> route) => false);
  }
}
