import 'package:flutter/material.dart';

export 'navigation_repo.dart';
part 'route_type.dart';

class NavigationRepository {
  Future<Object?>? goTo(BuildContext context, String routeName, {Object? arguments, RouteType routeType = RouteType.normal}) async {
    switch (routeType) {
      case RouteType.normal:
        _push(context, routeName, arguments);
        break;
      case RouteType.backLink:
        _pop(context, arguments);
        break;
      case RouteType.onlyThis:
        _pushAndRemoveAll(context, routeName, arguments);
        break;
      case RouteType.expect:
        return _pushAndExpect(context, routeName, arguments);
    }
  }

  void dismissDialog(BuildContext context) {
    _pop(context, null);
  }

  void _push(BuildContext context, String routeName, Object? arguments) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  Future<Object?> _pushAndExpect(BuildContext context, String routeName, Object? arguments) {
    return Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  void _pop(BuildContext context, Object? arguments) {
    Navigator.pop(context, arguments);
  }

  void _pushAndRemoveAll(BuildContext context, String routeName, Object? arguments) {
    Navigator.of(context).pushNamedAndRemoveUntil(routeName, (Route<dynamic> route) => false, arguments: arguments);
  }
}
