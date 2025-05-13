import 'package:flutter_modular/flutter_modular.dart';

class PaiementsModule extends Module {
  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (_, __) => Placeholder()),
  ];
}
