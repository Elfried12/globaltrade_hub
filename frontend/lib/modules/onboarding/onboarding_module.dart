import 'package:flutter_modular/flutter_modular.dart';
import 'views/onboarding_view.dart'; // Adjusted path

class OnboardingModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const OnboardingView());
  }
}