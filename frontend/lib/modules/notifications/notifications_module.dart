import 'package:flutter_modular/flutter_modular.dart';
import 'package:frontend/modules/notifications/views/notifications_view.dart';

class NotificationsModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const NotificationsView(), transition: TransitionType.fadeIn, duration: const Duration(milliseconds: 300));
  }
}