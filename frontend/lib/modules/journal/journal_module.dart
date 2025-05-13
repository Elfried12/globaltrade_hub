import 'package:flutter_modular/flutter_modular.dart';

class JournalModule extends Module {
  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (_, __) => Placeholder()),
  ];
}
