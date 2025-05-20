import 'package:flutter_modular/flutter_modular.dart';
import 'package:frontend/modules/dashboard/views/dashboard_user_view.dart';
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

class DashboardModule extends Module {
  @override
  void binds(Injector i) {
    // Add dependency injections here if needed (e.g., services)
  }

  @override
  void routes(RouteManager r) {
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
  }
}