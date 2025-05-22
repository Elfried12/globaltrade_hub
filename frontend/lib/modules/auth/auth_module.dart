// lib/modules/auth/auth_module.dart
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'views/register_view.dart';
import 'views/login_view.dart';
import 'views/auth_selection_view.dart';
import 'services/auth_service.dart';

class AuthModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<AuthService>(AuthService.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const AuthSelectionView());
    r.child('/register', child: (context) => RegisterView(authService: Modular.get<AuthService>()));
    r.child('/login', child: (context) => LoginView(authService: Modular.get<AuthService>())); // Correction ici
  }
}