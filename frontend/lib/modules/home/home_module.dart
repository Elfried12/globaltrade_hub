import 'package:flutter_modular/flutter_modular.dart';
import 'views/home_view.dart';

class HomeModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => const HomeView(),
    );
  }
}

