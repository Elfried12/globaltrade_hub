import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'views/register_view.dart';
import 'views/login_view.dart'; // 🆕

class AuthModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const LoginView());
  }
}
