import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'app_module.dart';

void main() {
  // ✅ Ajout de la route de démarrage
  Modular.setInitialRoute('/auth');
  runApp(ModularApp(module: AppModule(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'GlobalTrade Hub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Orbitron',
        useMaterial3: true,
        colorSchemeSeed: Colors.blueAccent,
      ),
      routerConfig: Modular.routerConfig,
    );
  }
}
