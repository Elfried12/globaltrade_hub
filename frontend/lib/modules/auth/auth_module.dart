import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {
  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (_, __) => Placeholder()),
  ];
}
