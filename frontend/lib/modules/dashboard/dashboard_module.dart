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

class DashboardModule extends Module {
  @override
  void binds(Injector i) {
    // Add dependency injections here if needed (e.g., services)
  }

  @override
  void routes(RouteManager r) {
    // Routes pour les utilisateurs
    r.child('/', child: (context) => const DashboardUserView(), transition: TransitionType.fadeIn, duration: const Duration(milliseconds: 300));
    r.child('/home/', child: (context) => const DashboardHomeScreen(), transition: TransitionType.fadeIn, duration: const Duration(milliseconds: 300));
    r.child('/search/', child: (context) => const SearchSuppliersScreen(), transition: TransitionType.fadeIn, duration: const Duration(milliseconds: 300));
    r.child('/contact/', child: (context) => const ContactRequestsScreen(), transition: TransitionType.fadeIn, duration: const Duration(milliseconds: 300));
    r.child('/negotiations/', child: (context) => const NegotiationsScreen(), transition: TransitionType.fadeIn, duration: const Duration(milliseconds: 300));
    r.child('/complaints/', child: (context) => const ComplaintsScreen(), transition: TransitionType.fadeIn, duration: const Duration(milliseconds: 300));
    r.child('/premium/', child: (context) => const PremiumSubscriptionScreen(), transition: TransitionType.fadeIn, duration: const Duration(milliseconds: 300));
    r.child('/messaging/', child: (context) => const MessagingScreen(), transition: TransitionType.fadeIn, duration: const Duration(milliseconds: 300));
    r.child('/favorites/', child: (context) => const FavoritesScreen(), transition: TransitionType.fadeIn, duration: const Duration(milliseconds: 300));
    r.child('/documents/', child: (context) => const DocumentsScreen(), transition: TransitionType.fadeIn, duration: const Duration(milliseconds: 300));
    r.child('/profile/', child: (context) => const ProfileScreen(), transition: TransitionType.fadeIn, duration: const Duration(milliseconds: 300));

    // Routes pour les fournisseurs
    r.child('/fournisseur/', child: (context) => const DashboardFournisseurView(), transition: TransitionType.fadeIn, duration: const Duration(milliseconds: 300));
    r.child('/fournisseur/client-search/', child: (context) => const SupplierClientSearchScreen(), transition: TransitionType.fadeIn, duration: const Duration(milliseconds: 300));
    r.child('/fournisseur/documents/', child: (context) => const SupplierDocumentsScreen(), transition: TransitionType.fadeIn, duration: const Duration(milliseconds: 300));
    r.child('/fournisseur/favorites/', child: (context) => const SupplierFavoritesScreen(), transition: TransitionType.fadeIn, duration: const Duration(milliseconds: 300));
    r.child('/fournisseur/logistics-overview/', child: (context) => const SupplierLogisticsOverviewScreen(), transition: TransitionType.fadeIn, duration: const Duration(milliseconds: 300));
    r.child('/fournisseur/logistics/', child: (context) => const SupplierLogisticsScreen(), transition: TransitionType.fadeIn, duration: const Duration(milliseconds: 300));
    r.child('/fournisseur/messaging/', child: (context) => const SupplierMessagingScreen(), transition: TransitionType.fadeIn, duration: const Duration(milliseconds: 300));
    r.child('/fournisseur/notifications-overview/', child: (context) => const SupplierNotificationsOverviewScreen(), transition: TransitionType.fadeIn, duration: const Duration(milliseconds: 300));
    r.child('/fournisseur/notifications/', child: (context) => const SupplierNotificationsScreen(), transition: TransitionType.fadeIn, duration: const Duration(milliseconds: 300));
    r.child('/fournisseur/offers-overview/', child: (context) => const SupplierOffersOverviewScreen(), transition: TransitionType.fadeIn, duration: const Duration(milliseconds: 300));
    r.child('/fournisseur/offers/', child: (context) => const SupplierOffersScreen(), transition: TransitionType.fadeIn, duration: const Duration(milliseconds: 300));
    r.child('/fournisseur/orders-overview/', child: (context) => const SupplierOrdersOverviewScreen(), transition: TransitionType.fadeIn, duration: const Duration(milliseconds: 300));
    r.child('/fournisseur/orders/', child: (context) => const SupplierOrdersScreen(), transition: TransitionType.fadeIn, duration: const Duration(milliseconds: 300));
    r.child('/fournisseur/premium/', child: (context) => const SupplierPremiumScreen(), transition: TransitionType.fadeIn, duration: const Duration(milliseconds: 300));
    r.child('/fournisseur/profile/', child: (context) => const SupplierProfileScreen(), transition: TransitionType.fadeIn, duration: const Duration(milliseconds: 300));
    r.child('/fournisseur/reviews-overview/', child: (context) => const SupplierReviewsOverviewScreen(), transition: TransitionType.fadeIn, duration: const Duration(milliseconds: 300));
    r.child('/fournisseur/reviews/', child: (context) => const SupplierReviewsScreen(), transition: TransitionType.fadeIn, duration: const Duration(milliseconds: 300));
    r.child('/fournisseur/transactions-overview/', child: (context) => const SupplierTransactionsOverviewScreen(), transition: TransitionType.fadeIn, duration: const Duration(milliseconds: 300));
  }
}