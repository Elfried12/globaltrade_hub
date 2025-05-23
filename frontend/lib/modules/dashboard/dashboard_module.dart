import 'package:flutter_modular/flutter_modular.dart';
import 'package:frontend/modules/dashboard/views/dashboard_user_view.dart';
import 'package:frontend/modules/dashboard/views/dashboard_fournisseur_view.dart';
import 'package:frontend/modules/dashboard/views/dashboard_home_screen.dart';
import 'package:frontend/modules/dashboard/views/search_suppliers_screen.dart';
import 'package:frontend/modules/dashboard/views/contact_requests_screen.dart';
import 'package:frontend/modules/dashboard/views/negotiations_screen.dart';
import 'package:frontend/modules/dashboard/views/complaints_screen.dart';
import 'package:frontend/modules/dashboard/views/premium_subscription_screen.dart';
import 'package:frontend/modules/dashboard/views/messaging_screen.dart';
import 'package:frontend/modules/dashboard/views/favorites_screen.dart';
import 'package:frontend/modules/dashboard/views/documents_screen.dart';
import 'package:frontend/modules/dashboard/views/profile_screen.dart';
import 'package:frontend/modules/dashboard/views/supplier_client_search_screen.dart';
import 'package:frontend/modules/dashboard/views/supplier_documents_screen.dart';
import 'package:frontend/modules/dashboard/views/supplier_favorites_screen.dart';
import 'package:frontend/modules/dashboard/views/supplier_logistics_overview_screen.dart';
import 'package:frontend/modules/dashboard/views/supplier_logistics_screen.dart';
import 'package:frontend/modules/dashboard/views/supplier_messaging_screen.dart';
import 'package:frontend/modules/dashboard/views/supplier_notifications_overview_screen.dart';
import 'package:frontend/modules/dashboard/views/supplier_notifications_screen.dart';
import 'package:frontend/modules/dashboard/views/supplier_offers_overview_screen.dart';
import 'package:frontend/modules/dashboard/views/supplier_offers_screen.dart';
import 'package:frontend/modules/dashboard/views/supplier_orders_overview_screen.dart';
import 'package:frontend/modules/dashboard/views/supplier_orders_screen.dart';
import 'package:frontend/modules/dashboard/views/supplier_premium_screen.dart';
import 'package:frontend/modules/dashboard/views/supplier_profile_screen.dart';
import 'package:frontend/modules/dashboard/views/supplier_reviews_overview_screen.dart';
import 'package:frontend/modules/dashboard/views/supplier_reviews_screen.dart';
import 'package:frontend/modules/dashboard/views/supplier_transactions_overview_screen.dart';
import 'package:frontend/modules/dashboard/views/dashboard_admin_view.dart';

class DashboardModule extends Module {
  @override
  void binds(Injector i) {
    // Add dependency injections here if needed (e.g., services)
  }

  @override
  void routes(RouteManager r) {
    // Routes pour les utilisateurs
    r.child('/', child: (context) => const DashboardUserView(), transition: TransitionType.rightToLeftWithFade, duration: const Duration(milliseconds: 400));
    r.child('/home/', child: (context) => const DashboardHomeScreen(), transition: TransitionType.rightToLeftWithFade, duration: const Duration(milliseconds: 400));
    r.child('/search/', child: (context) => const SearchSuppliersScreen(), transition: TransitionType.rightToLeftWithFade, duration: const Duration(milliseconds: 400));
    r.child('/contact/', child: (context) => const ContactRequestsScreen(), transition: TransitionType.rightToLeftWithFade, duration: const Duration(milliseconds: 400));
    r.child('/negotiations/', child: (context) => const NegotiationsScreen(), transition: TransitionType.upToDown, duration: const Duration(milliseconds: 400));
    r.child('/complaints/', child: (context) => const ComplaintsScreen(), transition: TransitionType.upToDown, duration: const Duration(milliseconds: 400));
    r.child('/premium/', child: (context) => const PremiumSubscriptionScreen(), transition: TransitionType.downToUp, duration: const Duration(milliseconds: 400));
    r.child('/messaging/', child: (context) => const MessagingScreen(), transition: TransitionType.rightToLeftWithFade, duration: const Duration(milliseconds: 400));
    r.child('/favorites/', child: (context) => const FavoritesScreen(), transition: TransitionType.rightToLeftWithFade, duration: const Duration(milliseconds: 400));
    r.child('/documents/', child: (context) => const DocumentsScreen(), transition: TransitionType.rightToLeftWithFade, duration: const Duration(milliseconds: 400));
    r.child('/profile/', child: (context) => const ProfileScreen(), transition: TransitionType.downToUp, duration: const Duration(milliseconds: 400));

    // Routes pour les fournisseurs
    r.child('/fournisseur/', child: (context) => const DashboardFournisseurView(), transition: TransitionType.leftToRightWithFade, duration: const Duration(milliseconds: 400));
    r.child('/fournisseur/client-search/', child: (context) => const SupplierClientSearchScreen(), transition: TransitionType.leftToRightWithFade, duration: const Duration(milliseconds: 400));
    r.child('/fournisseur/documents/', child: (context) => const SupplierDocumentsScreen(), transition: TransitionType.leftToRightWithFade, duration: const Duration(milliseconds: 400));
    r.child('/fournisseur/favorites/', child: (context) => const SupplierFavoritesScreen(), transition: TransitionType.leftToRightWithFade, duration: const Duration(milliseconds: 400));
    r.child('/fournisseur/logistics-overview/', child: (context) => const SupplierLogisticsOverviewScreen(), transition: TransitionType.leftToRightWithFade, duration: const Duration(milliseconds: 400));
    r.child('/fournisseur/logistics/', child: (context) => const SupplierLogisticsScreen(), transition: TransitionType.leftToRightWithFade, duration: const Duration(milliseconds: 400));
    r.child('/fournisseur/messaging/', child: (context) => const SupplierMessagingScreen(), transition: TransitionType.leftToRightWithFade, duration: const Duration(milliseconds: 400));
    r.child('/fournisseur/notifications-overview/', child: (context) => const SupplierNotificationsOverviewScreen(), transition: TransitionType.upToDown, duration: const Duration(milliseconds: 400));
    r.child('/fournisseur/notifications/', child: (context) => const SupplierNotificationsScreen(), transition: TransitionType.upToDown, duration: const Duration(milliseconds: 400));
    r.child('/fournisseur/offers-overview/', child: (context) => const SupplierOffersOverviewScreen(), transition: TransitionType.leftToRightWithFade, duration: const Duration(milliseconds: 400));
    r.child('/fournisseur/offers/', child: (context) => const SupplierOffersScreen(), transition: TransitionType.leftToRightWithFade, duration: const Duration(milliseconds: 400));
    r.child('/fournisseur/orders-overview/', child: (context) => const SupplierOrdersOverviewScreen(), transition: TransitionType.leftToRightWithFade, duration: const Duration(milliseconds: 400));
    r.child('/fournisseur/orders/', child: (context) => const SupplierOrdersScreen(), transition: TransitionType.leftToRightWithFade, duration: const Duration(milliseconds: 400));
    r.child('/fournisseur/premium/', child: (context) => const SupplierPremiumScreen(), transition: TransitionType.downToUp, duration: const Duration(milliseconds: 400));
    r.child('/fournisseur/profile/', child: (context) => const SupplierProfileScreen(), transition: TransitionType.downToUp, duration: const Duration(milliseconds: 400));
    r.child('/fournisseur/reviews-overview/', child: (context) => const SupplierReviewsOverviewScreen(), transition: TransitionType.upToDown, duration: const Duration(milliseconds: 400));
    r.child('/fournisseur/reviews/', child: (context) => const SupplierReviewsScreen(), transition: TransitionType.upToDown, duration: const Duration(milliseconds: 400));
    r.child('/fournisseur/transactions-overview/', child: (context) => const SupplierTransactionsOverviewScreen(), transition: TransitionType.leftToRightWithFade, duration: const Duration(milliseconds: 400));
    r.child('/fournisseur/negotiations/', child: (context) => const NegotiationsScreen(), transition: TransitionType.upToDown, duration: const Duration(milliseconds: 400));

    // Route pour l'administrateur
    r.child('/admin/', child: (context) => const DashboardAdminView(), transition: TransitionType.scale, duration: const Duration(milliseconds: 400));
  }
}