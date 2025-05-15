import 'package:flutter_modular/flutter_modular.dart';
import 'views/splash_view.dart'; // Adjusted path

class SplashModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const SplashView());
  }
}