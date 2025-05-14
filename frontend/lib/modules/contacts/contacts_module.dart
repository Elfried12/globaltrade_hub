import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ContactsModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const Placeholder());
  }
}
