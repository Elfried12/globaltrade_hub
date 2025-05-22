import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:frontend/modules/auth/auth_module.dart';
import 'package:frontend/modules/contacts/contacts_module.dart';
import 'package:frontend/modules/dashboard/dashboard_module.dart';
import 'package:frontend/modules/douanes/douanes_module.dart';
import 'package:frontend/modules/evaluations/evaluations_module.dart';
import 'package:frontend/modules/fournisseurs/fournisseurs_module.dart';
import 'package:frontend/modules/home/home_module.dart';
import 'package:frontend/modules/journal/journal_module.dart';
import 'package:frontend/modules/logistique/logistique_module.dart';
import 'package:frontend/modules/notifications/notifications_module.dart';
import 'package:frontend/modules/onboarding/onboarding_module.dart';
import 'package:frontend/modules/paiements/paiements_module.dart';
import 'package:frontend/modules/produits/produits_module.dart';
import 'package:frontend/modules/splash/splash_module.dart';
import 'package:frontend/modules/transactions/transactions_module.dart';
import 'package:frontend/modules/utilisateurs/utilisateurs_module.dart';
import 'app_module.dart';

void main() {
  Modular.setInitialRoute('/splash');
  runApp(ModularApp(module: AppModule(), child: const MyApp()));
}

class AppModule extends Module {
  @override
  void binds(Injector i) {
    // pas besoin de Bind ici si tous tes services sont dans leurs modules respectifs
  }

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
    // et tous les autres modules…
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'GlobalTrade Hub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF6C63FF),
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
      ),
      routerConfig: Modular.routerConfig,
    );
  }
}