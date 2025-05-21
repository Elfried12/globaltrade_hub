import 'package:flutter_modular/flutter_modular.dart';
import 'package:frontend/modules/logistique/views/logistique_view.dart';

class LogistiqueModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const LogistiqueView(), transition: TransitionType.fadeIn, duration: const Duration(milliseconds: 300));
  }
}