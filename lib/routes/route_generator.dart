


import 'package:flutter/material.dart';
import 'package:smart_health_reminder/modules/dashboard/views/dashboard_view.dart';
import 'package:smart_health_reminder/routes/routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.dashboard:
        return MaterialPageRoute(
          builder: (_) => const DashboardView(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const DashboardView(),
        );
    }
  }
}