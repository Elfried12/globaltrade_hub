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
import 'modules/home/home_module.dart';
import 'modules/splash/splash_module.dart';
import 'modules/onboarding/onboarding_module.dart';
import 'modules/dashboard/dashboard_module.dart'; // Ajouté

class AppModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.module('/auth', module: AuthModule());
    r.module('/utilisateurs', module: UtilisateursModule());
    r.module('/contacts', module: ContactsModule());
    r.module('/douanes', module: DouanesModule());
    r.module('/evaluations', module: EvaluationsModule());
    r.module('/journal', module: JournalModule());
    r.module('/logistique', module: LogistiqueModule());
    r.module('/notifications', module: NotificationsModule());
    r.module('/paiements', module: PaiementsModule());
    r.module('/produits', module: ProduitsModule());
    r.module('/fournisseurs', module: FournisseursModule());
    r.module('/transactions', module: TransactionsModule());
    r.module('/home', module: HomeModule());
    r.module('/splash', module: SplashModule());
    r.module('/onboarding', module: OnboardingModule());
    r.module('/dashboard', module: DashboardModule()); // Ajouté
  }
}