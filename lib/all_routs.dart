



import 'package:flutter/material.dart';

import 'package:teacherapp/views/dashBoard/teacherDashBoard_Page.dart';
import 'package:teacherapp/views/auth/login_screen.dart';
import 'package:teacherapp/views/auth/password_screen.dart';




const String login = '/login';
const String password = '/password';
const String techDashboard = '/techDashboard';








class RouterConfigs {
  static Route? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
        case password:
        return MaterialPageRoute(builder: (_) => PasswordScreen());
        case techDashboard:
        return MaterialPageRoute(builder: (_) => TeacherDashboardScreen());
      
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text("Page Not Found"),
            ),
          ),
        );
    }
  }
}