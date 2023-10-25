import 'package:flutter/material.dart';

export 'navigation_repo.dart';
part 'route_types.dart';

class NavigationRepository {
  void goTo(BuildContext context, String routeName, {Object? arguments, RouteType routeType = RouteType.normal}) {
    switch (routeType) {
      case RouteType.normal:
        _push(context, routeName, arguments);
        break;
      case RouteType.backLink:
        _pop(context);
        break;
      case RouteType.onlyThis:
        _pushAndRemoveAll(context, routeName, arguments);
        break;
    }
  }

  void dismissDialog(BuildContext context) {
    _pop(context);
  }

  void _push(BuildContext context, String routeName, Object? arguments) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  void _pop(BuildContext context) {
    Navigator.pop(context);
  }

  void _pushAndRemoveAll(BuildContext context, String routeName, Object? arguments) {
    Navigator.of(context).pushNamedAndRemoveUntil(routeName, (Route<dynamic> route) => false, arguments: arguments);
  }
}
