import 'package:flutter/material.dart';


import '../../view/home_screen.dart';
import 'routes_name.dart';


class Routes {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text("No page route define"),
            ),
          );
        });
    }
  }
}
