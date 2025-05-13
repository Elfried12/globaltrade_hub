import 'package:flutter_modular/flutter_modular.dart';

import 'modules/auth/auth_module.dart';
import 'modules/utilisateurs/utilisateurs_module.dart';
import 'modules/contacts/contacts_module.dart';
import 'modules/douanes/douanes_module.dart';
import 'modules/evaluations/evaluations_module.dart';
import 'modules/journal/journal_module.dart';
import 'modules/logistique/logistique_module.dart';
import 'modules/notifications/notifications_module.dart';
import 'modules/paiements/paiements_module.dart';
import 'modules/produits/produits_module.dart';
import 'modules/fournisseurs/fournisseurs_module.dart';
import 'modules/transactions/transactions_module.dart';

class AppModule extends Module {
  @override
  List<ModularRoute> get routes => [
    ModuleRoute('/auth', module: AuthModule()),
    ModuleRoute('/utilisateurs', module: UtilisateursModule()),
    ModuleRoute('/contacts', module: ContactsModule()),
    ModuleRoute('/douanes', module: DouanesModule()),
    ModuleRoute('/evaluations', module: EvaluationsModule()),
    ModuleRoute('/journal', module: JournalModule()),
    ModuleRoute('/logistique', module: LogistiqueModule()),
    ModuleRoute('/notifications', module: NotificationsModule()),
    ModuleRoute('/paiements', module: PaiementsModule()),
    ModuleRoute('/produits', module: ProduitsModule()),
    ModuleRoute('/fournisseurs', module: FournisseursModule()),
    ModuleRoute('/transactions', module: TransactionsModule()),
  ];
}
