import 'package:flutter/material.dart';

import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/register_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case '/dashboard':
        return MaterialPageRoute(builder: (_) => DashboardScreen());

      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text("Ruta no encontrada")),
          ),
        );
    }
  }
}