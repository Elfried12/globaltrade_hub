import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:frontend/modules/dashboard/views/dashboard_home_screen.dart';
import 'package:frontend/modules/dashboard/views/search_suppliers_screen.dart';
import 'package:frontend/modules/dashboard/views/contact_requests_screen.dart';
import 'package:frontend/modules/dashboard/views/negotiations_screen.dart';
import 'package:frontend/modules/dashboard/views/complaints_screen.dart';
import 'package:frontend/modules/notifications/views/notifications_view.dart';
import 'package:frontend/modules/logistique/views/logistique_view.dart';
import 'package:frontend/modules/dashboard/views/premium_subscription_screen.dart';
import 'package:frontend/modules/dashboard/views/messaging_screen.dart';
import 'package:frontend/modules/dashboard/views/favorites_screen.dart';
import 'package:frontend/modules/dashboard/views/documents_screen.dart';
import 'package:frontend/modules/dashboard/views/profile_screen.dart';
import 'package:flutter/rendering.dart';

class DashboardUserView extends StatefulWidget {
  const DashboardUserView({super.key});

  @override
  State<DashboardUserView> createState() => _DashboardUserViewState();
}

Widget _buildSidebarItem({
  required GlobalKey<ScaffoldState>? scaffoldKey,
  required IconData icon,
  required String title,
  required VoidCallback onTap,
  required bool isExpanded,
  required bool isDarkMode,
}) {
  return ListTile(
    leading: Icon(icon, color: const Color(0xFF718096), size: 20),
    title: isExpanded
        ? Text(
            title,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              color: isDarkMode ? Colors.white : const Color(0xFF2D3748),
            ),
          )
        : null,
    onTap: onTap,
    hoverColor: isDarkMode ? Colors.white.withOpacity(0.1) : const Color(0xFFF7F9FC),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
    minLeadingWidth: 20,
  );
}

class _DashboardUserViewState extends State<DashboardUserView> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSidebarExpanded = true;
  int _unreadNotifications = 5;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isDarkMode = false;
  late bool isMobile;
  late bool isTablet;
  late bool isDesktop;
  late bool isSmallScreen;
  int _selectedIndex = 0;
  bool _isNavBarVisible = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        setState(() {
          _isNavBarVisible = false;
        });
      } else if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
        setState(() {
          _isNavBarVisible = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Modular.to.navigate('/dashboard/home/');
        break;
      case 1:
        Modular.to.navigate('/dashboard/search/');
        break;
      case 2:
        Modular.to.navigate('/dashboard/negotiations/');
        break;
      case 3:
        Modular.to.navigate('/notifications/');
        break;
      case 4:
        Modular.to.navigate('/dashboard/profile/');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    isDesktop = width >= 800;
    isTablet = width >= 600 && width < 800;
    isMobile = width < 600;
    isSmallScreen = width < 480;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: _isDarkMode ? const Color(0xFF121212) : const Color(0xFFF7F9FC),
      drawer: isDesktop ? null : _buildDrawer(),
      body: Row(
        children: [
          if (!isMobile) _buildSidebar(),
          Expanded(
            child: Column(
              children: [
                _buildHeader(isDesktop),
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Padding(
                      padding: EdgeInsets.all(isSmallScreen ? 8.0 : isMobile ? 12.0 : 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (isMobile)
                            _buildMobileKpiCarousel()
                          else
                            _buildKpiCards(),
                          const SizedBox(height: 16),
                          _buildSearchSection(),
                          const SizedBox(height: 16),
                          _buildRecentNegotiations(),
                          const SizedBox(height: 16),
                          _buildRecentNotifications(),
                          SizedBox(height: isMobile ? 80 : 0), // Espace pour la bottom nav bar
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: isMobile
          ? AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: _isNavBarVisible ? 70.0 : 0.0,
              child: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.home, size: 24),
                    activeIcon: const Icon(Icons.home, size: 28, color: Color(0xFF6C63FF)),
                    label: 'Accueil',
                    tooltip: 'Tableau de bord',
                    backgroundColor: _isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.search, size: 24),
                    activeIcon: const Icon(Icons.search, size: 28, color: Color(0xFF6C63FF)),
                    label: 'Rechercher',
                    tooltip: 'Recherche fournisseurs',
                    backgroundColor: _isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.handshake, size: 24),
                    activeIcon: const Icon(Icons.handshake, size: 28, color: Color(0xFF6C63FF)),
                    label: 'Négocier',
                    tooltip: 'Négociations & transactions',
                    backgroundColor: _isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                  ),
                  BottomNavigationBarItem(
                    icon: Stack(
                      children: [
                        const Icon(Icons.notifications, size: 24),
                        if (_unreadNotifications > 0)
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: Color(0xFFE53E3E),
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '$_unreadNotifications',
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    activeIcon: Stack(
                      children: [
                        const Icon(Icons.notifications, size: 28, color: Color(0xFF6C63FF)),
                        if (_unreadNotifications > 0)
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: Color(0xFFE53E3E),
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '$_unreadNotifications',
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    label: 'Alertes',
                    tooltip: 'Notifications',
                    backgroundColor: _isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.person, size: 24),
                    activeIcon: const Icon(Icons.person, size: 28, color: Color(0xFF6C63FF)),
                    label: 'Profil',
                    tooltip: 'Profil & paramètres',
                    backgroundColor: _isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: const Color(0xFF6C63FF),
                unselectedItemColor: _isDarkMode ? Colors.grey[400] : const Color(0xFF718096),
                selectedLabelStyle: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: GoogleFonts.montserrat(
                  fontSize: 12,
                ),
                backgroundColor: _isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                elevation: 8,
                type: BottomNavigationBarType.fixed,
                onTap: _onItemTapped,
              ),
            )
          : null,
    );
  }

  Widget _buildSidebar() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: _isSidebarExpanded ? 220 : 70,
      color: _isDarkMode ? const Color(0xFF1E1E1E) : const Color(0xFFFFFFFF),
      child: Column(
        children: [
          const SizedBox(height: 24),
          IconButton(
            icon: Icon(
              _isSidebarExpanded ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
              color: _isDarkMode ? Colors.white : const Color(0xFF718096),
              size: 20,
            ),
            onPressed: () {
              setState(() {
                _isSidebarExpanded = !_isSidebarExpanded;
              });
            },
            tooltip: _isSidebarExpanded ? 'Réduire' : 'Agrandir',
            constraints: const BoxConstraints(minHeight: 44, minWidth: 44),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSidebarItem(
                  scaffoldKey: null,
                  icon: Icons.dashboard_outlined,
                  title: 'Tableau de bord',
                  onTap: () {
                    Modular.to.navigate('/dashboard/home/');
                  },
                  isExpanded: _isSidebarExpanded,
                  isDarkMode: _isDarkMode,
                ),
                _buildSidebarItem(
                  scaffoldKey: null,
                  icon: Icons.search_outlined,
                  title: 'Recherche fournisseurs',
                  onTap: () {
                    Modular.to.navigate('/dashboard/search/');
                  },
                  isExpanded: _isSidebarExpanded,
                  isDarkMode: _isDarkMode,
                ),
                _buildSidebarItem(
                  scaffoldKey: null,
                  icon: Icons.contact_mail_outlined,
                  title: 'Mes demandes de contact',
                  onTap: () {
                    Modular.to.navigate('/dashboard/contact/');
                  },
                  isExpanded: _isSidebarExpanded,
                  isDarkMode: _isDarkMode,
                ),
                _buildSidebarItem(
                  scaffoldKey: null,
                  icon: Icons.handshake_outlined,
                  title: 'Négociations & transactions',
                  onTap: () {
                    Modular.to.navigate('/dashboard/negotiations/');
                  },
                  isExpanded: _isSidebarExpanded,
                  isDarkMode: _isDarkMode,
                ),
                _buildSidebarItem(
                  scaffoldKey: null,
                  icon: Icons.report_problem_outlined,
                  title: 'Plaintes & évaluations',
                  onTap: () {
                    Modular.to.navigate('/dashboard/complaints/');
                  },
                  isExpanded: _isSidebarExpanded,
                  isDarkMode: _isDarkMode,
                ),
                _buildSidebarItem(
                  scaffoldKey: null,
                  icon: Icons.notifications_outlined,
                  title: 'Notifications',
                  onTap: () {
                    Modular.to.navigate('/notifications/');
                  },
                  isExpanded: _isSidebarExpanded,
                  isDarkMode: _isDarkMode,
                ),
                _buildSidebarItem(
                  scaffoldKey: null,
                  icon: Icons.local_shipping_outlined,
                  title: 'Logistique & douanes',
                  onTap: () {
                    Modular.to.navigate('/logistique/');
                  },
                  isExpanded: _isSidebarExpanded,
                  isDarkMode: _isDarkMode,
                ),
                _buildSidebarItem(
                  scaffoldKey: null,
                  icon: Icons.star_border_outlined,
                  title: 'Abonnement Premium',
                  onTap: () {
                    Modular.to.navigate('/dashboard/premium/');
                  },
                  isExpanded: _isSidebarExpanded,
                  isDarkMode: _isDarkMode,
                ),
                _buildSidebarItem(
                  scaffoldKey: null,
                  icon: Icons.message_outlined,
                  title: 'Messagerie interne',
                  onTap: () {
                    Modular.to.navigate('/dashboard/messaging/');
                  },
                  isExpanded: _isSidebarExpanded,
                  isDarkMode: _isDarkMode,
                ),
                _buildSidebarItem(
                  scaffoldKey: null,
                  icon: Icons.favorite_border,
                  title: 'Favoris & recommandations',
                  onTap: () {
                    Modular.to.navigate('/dashboard/favorites/');
                  },
                  isExpanded: _isSidebarExpanded,
                  isDarkMode: _isDarkMode,
                ),
                _buildSidebarItem(
                  scaffoldKey: null,
                  icon: Icons.description_outlined,
                  title: 'Documents & factures',
                  onTap: () {
                    Modular.to.navigate('/dashboard/documents/');
                  },
                  isExpanded: _isSidebarExpanded,
                  isDarkMode: _isDarkMode,
                ),
                _buildSidebarItem(
                  scaffoldKey: null,
                  icon: Icons.person_outline,
                  title: 'Profil & paramètres',
                  onTap: () {
                    Modular.to.navigate('/dashboard/profile/');
                  },
                  isExpanded: _isSidebarExpanded,
                  isDarkMode: _isDarkMode,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: _isDarkMode ? const Color(0xFF1E1E1E) : const Color(0xFFFFFFFF),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6C63FF), Color(0xFF00FFFF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/gthint.png',
                  height: isSmallScreen ? 32 : 40,
                ),
                const SizedBox(height: 16),
                Text(
                  'GlobalTrade Hub',
                  style: GoogleFonts.montserrat(
                    fontSize: isSmallScreen ? 16 : 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          _buildSidebarItem(
            scaffoldKey: _scaffoldKey,
            icon: Icons.dashboard_outlined,
            title: 'Tableau de bord',
            onTap: () {
              Modular.to.navigate('/dashboard/home/');
              _scaffoldKey.currentState?.closeDrawer();
            },
            isExpanded: true,
            isDarkMode: _isDarkMode,
          ),
          _buildSidebarItem(
            scaffoldKey: _scaffoldKey,
            icon: Icons.search_outlined,
            title: 'Recherche fournisseurs',
            onTap: () {
              Modular.to.navigate('/dashboard/search/');
              _scaffoldKey.currentState?.closeDrawer();
            },
            isExpanded: true,
            isDarkMode: _isDarkMode,
          ),
          _buildSidebarItem(
            scaffoldKey: _scaffoldKey,
            icon: Icons.contact_mail_outlined,
            title: 'Mes demandes de contact',
            onTap: () {
              Modular.to.navigate('/dashboard/contact/');
              _scaffoldKey.currentState?.closeDrawer();
            },
            isExpanded: true,
            isDarkMode: _isDarkMode,
          ),
          _buildSidebarItem(
            scaffoldKey: _scaffoldKey,
            icon: Icons.handshake_outlined,
            title: 'Négociations & transactions',
            onTap: () {
              Modular.to.navigate('/dashboard/negotiations/');
              _scaffoldKey.currentState?.closeDrawer();
            },
            isExpanded: true,
            isDarkMode: _isDarkMode,
          ),
          _buildSidebarItem(
            scaffoldKey: _scaffoldKey,
            icon: Icons.report_problem_outlined,
            title: 'Plaintes & évaluations',
            onTap: () {
              Modular.to.navigate('/dashboard/complaints/');
              _scaffoldKey.currentState?.closeDrawer();
            },
            isExpanded: true,
            isDarkMode: _isDarkMode,
          ),
          _buildSidebarItem(
            scaffoldKey: _scaffoldKey,
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            onTap: () {
              Modular.to.navigate('/notifications/');
              _scaffoldKey.currentState?.closeDrawer();
            },
            isExpanded: true,
            isDarkMode: _isDarkMode,
          ),
          _buildSidebarItem(
            scaffoldKey: _scaffoldKey,
            icon: Icons.local_shipping_outlined,
            title: 'Logistique & douanes',
            onTap: () {
              Modular.to.navigate('/logistique/');
              _scaffoldKey.currentState?.closeDrawer();
            },
            isExpanded: true,
            isDarkMode: _isDarkMode,
          ),
          _buildSidebarItem(
            scaffoldKey: _scaffoldKey,
            icon: Icons.star_border_outlined,
            title: 'Abonnement Premium',
            onTap: () {
              Modular.to.navigate('/dashboard/premium/');
              _scaffoldKey.currentState?.closeDrawer();
            },
            isExpanded: true,
            isDarkMode: _isDarkMode,
          ),
          _buildSidebarItem(
            scaffoldKey: _scaffoldKey,
            icon: Icons.message_outlined,
            title: 'Messagerie interne',
            onTap: () {
              Modular.to.navigate('/dashboard/messaging/');
              _scaffoldKey.currentState?.closeDrawer();
            },
            isExpanded: true,
            isDarkMode: _isDarkMode,
          ),
          _buildSidebarItem(
            scaffoldKey: _scaffoldKey,
            icon: Icons.favorite_border,
            title: 'Favoris & recommandations',
            onTap: () {
              Modular.to.navigate('/dashboard/favorites/');
              _scaffoldKey.currentState?.closeDrawer();
            },
            isExpanded: true,
            isDarkMode: _isDarkMode,
          ),
          _buildSidebarItem(
            scaffoldKey: _scaffoldKey,
            icon: Icons.description_outlined,
            title: 'Documents & factures',
            onTap: () {
              Modular.to.navigate('/dashboard/documents/');
              _scaffoldKey.currentState?.closeDrawer();
            },
            isExpanded: true,
            isDarkMode: _isDarkMode,
          ),
          _buildSidebarItem(
            scaffoldKey: _scaffoldKey,
            icon: Icons.person_outline,
            title: 'Profil & paramètres',
            onTap: () {
              Modular.to.navigate('/dashboard/profile/');
              _scaffoldKey.currentState?.closeDrawer();
            },
            isExpanded: true,
            isDarkMode: _isDarkMode,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isDesktop) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 8 : 12, vertical: isSmallScreen ? 4 : 8),
      decoration: BoxDecoration(
        color: _isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!isDesktop)
            IconButton(
              icon: Icon(
                Icons.menu,
                color: _isDarkMode ? Colors.white : const Color(0xFF2D3748),
                size: 20,
              ),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              tooltip: 'Menu',
              constraints: const BoxConstraints(minHeight: 44, minWidth: 44),
            ),
          GestureDetector(
            onTap: () {
              Modular.to.navigate('/dashboard/');
            },
            child: Image.asset(
              'assets/images/gthint.png',
              height: isSmallScreen ? 24 : 40,
            ),
          ),
          const SizedBox(width: 8),
          if (isDesktop)
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: _isDarkMode ? const Color(0xFF2D2D2D) : const Color(0xFFF7F9FC),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _searchController,
                  style: GoogleFonts.montserrat(
                    color: _isDarkMode ? Colors.white : const Color(0xFF2D3748),
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Rechercher produits ou fournisseurs...',
                    hintStyle: GoogleFonts.montserrat(
                      color: _isDarkMode ? Colors.grey[400] : const Color(0xFF718096),
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFF718096),
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          const Spacer(),
          IconButton(
            icon: Icon(
              _isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: _isDarkMode ? Colors.white : const Color(0xFF2D3748),
              size: 20,
            ),
            onPressed: _toggleTheme,
            tooltip: _isDarkMode ? 'Mode clair' : 'Mode sombre',
            constraints: const BoxConstraints(minHeight: 44, minWidth: 44),
          ),
          const SizedBox(width: 4),
          Stack(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: Color(0xFF2D3748),
                  size: 20,
                ),
                onPressed: () {
                  Modular.to.navigate('/notifications/');
                },
                tooltip: 'Notifications',
                constraints: const BoxConstraints(minHeight: 44, minWidth: 44),
              ),
              if (_unreadNotifications > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: Color(0xFFE53E3E),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$_unreadNotifications',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 4),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                Modular.to.navigate('/auth');
              } else if (value == 'profile') {
                Modular.to.navigate('/dashboard/profile/');
              } else if (value == 'settings') {
                Modular.to.navigate('/dashboard/profile/');
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'profile',
                child: Text(
                  'Mon profil',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: _isDarkMode ? Colors.white : const Color(0xFF2D3748),
                  ),
                ),
              ),
              PopupMenuItem(
                value: 'settings',
                child: Text(
                  'Paramètres',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: _isDarkMode ? Colors.white : const Color(0xFF2D3748),
                  ),
                ),
              ),
              PopupMenuItem(
                value: 'logout',
                child: Text(
                  'Déconnexion',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: _isDarkMode ? Colors.white : const Color(0xFF2D3748),
                  ),
                ),
              ),
            ],
            child: const CircleAvatar(
              radius: 16,
              backgroundColor: Color(0xFF6C63FF),
              child: Icon(Icons.person, color: Colors.white, size: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileKpiCarousel() {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        itemBuilder: (context, index) {
          final kpis = [
            {'title': 'Demandes en cours', 'value': '12', 'subTitle': '3 en attente', 'icon': Icons.contact_mail_outlined, 'gradient': const LinearGradient(colors: [Color(0xFF6C63FF), Color(0xFF00FFFF)])},
            {'title': 'Négociations actives', 'value': '8', 'subTitle': '500 000 FCFA', 'icon': Icons.handshake_outlined, 'gradient': const LinearGradient(colors: [Color(0xFF6C63FF), Color(0xFF00FFFF)])},
            {'title': 'Transactions validées', 'value': '45', 'subTitle': '2M FCFA', 'icon': Icons.check_circle_outline, 'gradient': const LinearGradient(colors: [Color(0xFF32D74B), Color(0xFF00FFFF)])},
            {'title': 'Plaintes en cours', 'value': '2', 'subTitle': 'En résolution', 'icon': Icons.report_problem_outlined, 'gradient': const LinearGradient(colors: [Color(0xFFE53E3E), Color(0xFFFF6B6B)])},
            {'title': 'Véhicules réservés', 'value': '3', 'subTitle': '2 en transit', 'icon': Icons.local_shipping_outlined, 'gradient': const LinearGradient(colors: [Color(0xFF6C63FF), Color(0xFF00FFFF)])},
            {'title': 'Notifications récentes', 'value': '5', 'subTitle': 'Non lues', 'icon': Icons.notifications_outlined, 'gradient': const LinearGradient(colors: [Color(0xFFE53E3E), Color(0xFFFF6B6B)])},
          ];
          final kpi = kpis[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildKpiCard(
              title: kpi['title'] as String,
              value: kpi['value'] as String,
              subTitle: kpi['subTitle'] as String,
              icon: kpi['icon'] as IconData,
              gradient: kpi['gradient'] as LinearGradient,
            ),
          );
        },
      ),
    );
  }

  Widget _buildKpiCards() {
    return GridView.count(
      crossAxisCount: isMobile ? 1 : isDesktop ? 3 : 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: isMobile ? 3 : isDesktop ? 2 : 2.5,
      children: [
        _buildKpiCard(
          title: 'Demandes en cours',
          value: '12',
          subTitle: '3 en attente',
          icon: Icons.contact_mail_outlined,
          gradient: const LinearGradient(
            colors: [Color(0xFF6C63FF), Color(0xFF00FFFF)],
          ),
        ),
        _buildKpiCard(
          title: 'Négociations actives',
          value: '8',
          subTitle: '500 000 FCFA',
          icon: Icons.handshake_outlined,
          gradient: const LinearGradient(
            colors: [Color(0xFF6C63FF), Color(0xFF00FFFF)],
          ),
        ),
        _buildKpiCard(
          title: 'Transactions validées',
          value: '45',
          subTitle: '2M FCFA',
          icon: Icons.check_circle_outline,
          gradient: const LinearGradient(
            colors: [Color(0xFF32D74B), Color(0xFF00FFFF)],
          ),
        ),
        _buildKpiCard(
          title: 'Plaintes en cours',
          value: '2',
          subTitle: 'En résolution',
          icon: Icons.report_problem_outlined,
          gradient: const LinearGradient(
            colors: [Color(0xFFE53E3E), Color(0xFFFF6B6B)],
          ),
        ),
        _buildKpiCard(
          title: 'Véhicules réservés',
          value: '3',
          subTitle: '2 en transit',
          icon: Icons.local_shipping_outlined,
          gradient: const LinearGradient(
            colors: [Color(0xFF6C63FF), Color(0xFF00FFFF)],
          ),
        ),
        _buildKpiCard(
          title: 'Notifications récentes',
          value: '5',
          subTitle: 'Non lues',
          icon: Icons.notifications_outlined,
          gradient: const LinearGradient(
            colors: [Color(0xFFE53E3E), Color(0xFFFF6B6B)],
          ),
        ),
      ],
    );
  }

  Widget _buildKpiCard({
    required String title,
    required String value,
    required String subTitle,
    required IconData icon,
    required LinearGradient gradient,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: isMobile ? 300 : null,
      decoration: BoxDecoration(
        color: _isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(_isDarkMode ? 0.2 : 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: gradient,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          color: _isDarkMode ? Colors.grey[400] : const Color(0xFF718096),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        value,
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: _isDarkMode ? Colors.white : const Color(0xFF2D3748),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (!isMobile)
                        const SizedBox(height: 4),
                      if (!isMobile)
                        Text(
                          subTitle,
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            color: _isDarkMode ? Colors.grey[400] : const Color(0xFF718096),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rechercher des fournisseurs & produits',
          style: GoogleFonts.montserrat(
            fontSize: isSmallScreen ? 18 : 20,
            fontWeight: FontWeight.bold,
            color: _isDarkMode ? Colors.white : const Color(0xFF2D3748),
          ),
        ),
        const SizedBox(height: 8),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: _isDarkMode ? const Color(0xFF2D2D2D) : Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(_isDarkMode ? 0.2 : 0.05),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Entrez un mot-clé...',
                  hintStyle: GoogleFonts.montserrat(
                    color: _isDarkMode ? Colors.grey[400] : const Color(0xFF718096),
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xFF718096),
                    size: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6C63FF), Color(0xFF00FFFF)],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 16 : 24, vertical: isSmallScreen ? 8 : 16),
                  minimumSize: const Size(44, 44),
                ),
                child: Text(
                  'Rechercher',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            if (!isMobile)
              const SizedBox(height: 8),
            if (!isMobile)
              Wrap(
                spacing: 8,
                children: [
                  _buildFilterChip('Zone géographique'),
                  _buildFilterChip('Disponibilité'),
                  _buildFilterChip('Prix'),
                  _buildFilterChip('Délai de livraison'),
                  _buildFilterChip('Catégorie'),
                  _buildFilterChip('Statut Premium'),
                ],
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label) {
    return FilterChip(
      label: Text(
        label,
        style: GoogleFonts.montserrat(fontSize: 12),
      ),
      onSelected: (value) {},
      backgroundColor: _isDarkMode ? const Color(0xFF2D2D2D) : const Color(0xFFF7F9FC),
      selectedColor: const Color(0xFF6C63FF),
      labelStyle: TextStyle(color: _isDarkMode ? Colors.white : const Color(0xFF2D3748)),
      checkmarkColor: Colors.white,
    );
  }

  Widget _buildRecentNegotiations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Négociations récentes',
          style: GoogleFonts.montserrat(
            fontSize: isSmallScreen ? 18 : 20,
            fontWeight: FontWeight.bold,
            color: _isDarkMode ? Colors.white : const Color(0xFF2D3748),
          ),
        ),
        const SizedBox(height: 8),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isMobile ? 1 : isDesktop ? 2 : 2,
            childAspectRatio: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: 2,
          itemBuilder: (context, index) {
            return index == 0
                ? _buildNegotiationItem(
                    supplier: 'Fournisseur A',
                    product: 'Biscuits 500g',
                    amount: '300 000 FCFA',
                    status: 'En cours',
                    progress: 0.7,
                  )
                : _buildNegotiationItem(
                    supplier: 'Fournisseur B',
                    product: 'Meubles de bureau',
                    amount: '1 200 000 FCFA',
                    status: 'Proposition envoyée',
                    progress: 0.4,
                  );
          },
        ),
      ],
    );
  }

  Widget _buildNegotiationItem({
    required String supplier,
    required String product,
    required String amount,
    required String status,
    required double progress,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: _isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(_isDarkMode ? 0.2 : 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        leading: CircularPercentIndicator(
          radius: 20,
          lineWidth: 3,
          percent: progress,
          center: Text(
            '${(progress * 100).toInt()}%',
            style: GoogleFonts.montserrat(fontSize: 12),
          ),
          progressColor: const Color(0xFF6C63FF),
          backgroundColor: _isDarkMode ? Colors.grey[700]! : const Color(0xFFF7F9FC),
        ),
        title: Text(
          supplier,
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: _isDarkMode ? Colors.white : const Color(0xFF2D3748),
          ),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          amount,
          style: GoogleFonts.montserrat(
            fontSize: 12,
            color: _isDarkMode ? Colors.grey[400] : const Color(0xFF718096),
          ),
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          status,
          style: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: status == 'En cours' ? const Color(0xFFE53E3E) : const Color(0xFF32D74B),
          ),
        ),
        onTap: () {},
      ),
    );
  }

  Widget _buildRecentNotifications() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notifications récentes',
          style: GoogleFonts.montserrat(
            fontSize: isSmallScreen ? 18 : 20,
            fontWeight: FontWeight.bold,
            color: _isDarkMode ? Colors.white : const Color(0xFF2D3748),
          ),
        ),
        const SizedBox(height: 8),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isMobile ? 1 : isDesktop ? 2 : 2,
            childAspectRatio: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: 2,
          itemBuilder: (context, index) {
            return index == 0
                ? _buildNotificationItem(
                    message: 'Votre demande avec Fournisseur A a été validée.',
                    time: 'Il y a 2 heures',
                    icon: Icons.check_circle_outline,
                    iconColor: const Color(0xFF32D74B),
                  )
                : _buildNotificationItem(
                    message: 'Réponse attendue sous 48h pour la négociation #123.',
                    time: 'Il y a 5 heures',
                    icon: Icons.hourglass_empty,
                    iconColor: const Color(0xFFE53E3E),
                  );
          },
        ),
      ],
    );
  }

  Widget _buildNotificationItem({
    required String message,
    required String time,
    required IconData icon,
    required Color iconColor,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: _isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(_isDarkMode ? 0.2 : 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        leading: Icon(icon, color: iconColor, size: 24),
        title: Text(
          message,
          style: GoogleFonts.montserrat(
            fontSize: 14,
            color: _isDarkMode ? Colors.white : const Color(0xFF2D3748),
          ),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          time,
          style: GoogleFonts.montserrat(
            fontSize: 12,
            color: _isDarkMode ? Colors.grey[400] : const Color(0xFF718096),
          ),
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () {},
      ),
    );
  }
}