import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart'; // Added this import

class Product {
  String name;
  String category;
  String price;
  String stock;
  String status;

  Product({
    required this.name,
    required this.category,
    required this.price,
    required this.stock,
    required this.status,
  });
}

class DashboardFournisseurView extends StatefulWidget {
  const DashboardFournisseurView({super.key});

  @override
  State<DashboardFournisseurView> createState() => _DashboardFournisseurViewState();
}

class _DashboardFournisseurViewState extends State<DashboardFournisseurView> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSidebarExpanded = true;
  int _unreadNotifications = 3;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isDarkMode = false;
  late bool isMobile;
  late bool isTablet;
  late bool isDesktop;
  late bool isSmallScreen;
  int _selectedIndex = 0;
  bool _isNavBarVisible = true;
  final ScrollController _scrollController = ScrollController();

  List<Product> products = [
    Product(name: 'Biscuits 500g', category: 'Alimentaire', price: '5000 FCFA', stock: '300 unités', status: 'Actif'),
    Product(name: 'Meubles de bureau', category: 'Mobilier', price: '150 000 FCFA', stock: '50 unités', status: 'Stock faible'),
  ];

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

  void _showAddProductDialog() {
    final nameController = TextEditingController();
    final categoryController = TextEditingController();
    final priceController = TextEditingController();
    final stockController = TextEditingController();
    bool isFormComplete = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: _isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              title: Text(
                'Ajouter un produit',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: _isDarkMode ? Colors.white : const Color(0xFF212121),
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      style: GoogleFonts.inter(color: _isDarkMode ? Colors.white : const Color(0xFF212121)),
                      decoration: InputDecoration(
                        labelText: 'Nom du produit *',
                        labelStyle: GoogleFonts.inter(color: _isDarkMode ? Colors.grey[400] : const Color(0xFF757575)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: _isDarkMode ? Colors.grey[700]! : Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xFF1E88E5)),
                        ),
                      ),
                      onChanged: (value) {
                        setDialogState(() {
                          isFormComplete = nameController.text.isNotEmpty &&
                              categoryController.text.isNotEmpty &&
                              priceController.text.isNotEmpty &&
                              stockController.text.isNotEmpty;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: categoryController,
                      style: GoogleFonts.inter(color: _isDarkMode ? Colors.white : const Color(0xFF212121)),
                      decoration: InputDecoration(
                        labelText: 'Catégorie *',
                        labelStyle: GoogleFonts.inter(color: _isDarkMode ? Colors.grey[400] : const Color(0xFF757575)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: _isDarkMode ? Colors.grey[700]! : Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xFF1E88E5)),
                        ),
                      ),
                      onChanged: (value) {
                        setDialogState(() {
                          isFormComplete = nameController.text.isNotEmpty &&
                              categoryController.text.isNotEmpty &&
                              priceController.text.isNotEmpty &&
                              stockController.text.isNotEmpty;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: priceController,
                      style: GoogleFonts.inter(color: _isDarkMode ? Colors.white : const Color(0xFF212121)),
                      decoration: InputDecoration(
                        labelText: 'Prix (FCFA) *',
                        labelStyle: GoogleFonts.inter(color: _isDarkMode ? Colors.grey[400] : const Color(0xFF757575)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: _isDarkMode ? Colors.grey[700]! : Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xFF1E88E5)),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setDialogState(() {
                          isFormComplete = nameController.text.isNotEmpty &&
                              categoryController.text.isNotEmpty &&
                              priceController.text.isNotEmpty &&
                              stockController.text.isNotEmpty;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: stockController,
                      style: GoogleFonts.inter(color: _isDarkMode ? Colors.white : const Color(0xFF212121)),
                      decoration: InputDecoration(
                        labelText: 'Stock (unités) *',
                        labelStyle: GoogleFonts.inter(color: _isDarkMode ? Colors.grey[400] : const Color(0xFF757575)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: _isDarkMode ? Colors.grey[700]! : Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xFF1E88E5)),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setDialogState(() {
                          isFormComplete = nameController.text.isNotEmpty &&
                              categoryController.text.isNotEmpty &&
                              priceController.text.isNotEmpty &&
                              stockController.text.isNotEmpty;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: isFormComplete ? 1.0 : 0.5,
                      backgroundColor: _isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF1E88E5)),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Annuler',
                    style: GoogleFonts.inter(
                      color: _isDarkMode ? Colors.grey[400] : const Color(0xFF757575),
                      fontSize: 14,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: isFormComplete
                      ? () {
                          setState(() {
                            products.add(Product(
                              name: nameController.text,
                              category: categoryController.text,
                              price: '${priceController.text} FCFA',
                              stock: '${stockController.text} unités',
                              status: 'Actif',
                            ));
                          });
                          Navigator.of(context).pop();
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E88E5),
                    disabledBackgroundColor: _isDarkMode ? Colors.grey[700]! : Colors.grey[400]!,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    minimumSize: const Size(44, 44),
                  ),
                  child: Text(
                    'Ajouter',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showEditProductDialog(int index) {
    final product = products[index];
    final nameController = TextEditingController(text: product.name);
    final categoryController = TextEditingController(text: product.category);
    final priceController = TextEditingController(text: product.price.replaceAll(' FCFA', ''));
    final stockController = TextEditingController(text: product.stock.replaceAll(' unités', ''));
    bool isFormComplete = true;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: _isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              title: Text(
                'Modifier un produit',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: _isDarkMode ? Colors.white : const Color(0xFF212121),
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      style: GoogleFonts.inter(color: _isDarkMode ? Colors.white : const Color(0xFF212121)),
                      decoration: InputDecoration(
                        labelText: 'Nom du produit *',
                        labelStyle: GoogleFonts.inter(color: _isDarkMode ? Colors.grey[400] : const Color(0xFF757575)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: _isDarkMode ? Colors.grey[700]! : Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xFF1E88E5)),
                        ),
                      ),
                      onChanged: (value) {
                        setDialogState(() {
                          isFormComplete = nameController.text.isNotEmpty &&
                              categoryController.text.isNotEmpty &&
                              priceController.text.isNotEmpty &&
                              stockController.text.isNotEmpty;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: categoryController,
                      style: GoogleFonts.inter(color: _isDarkMode ? Colors.white : const Color(0xFF212121)),
                      decoration: InputDecoration(
                        labelText: 'Catégorie *',
                        labelStyle: GoogleFonts.inter(color: _isDarkMode ? Colors.grey[400] : const Color(0xFF757575)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: _isDarkMode ? Colors.grey[700]! : Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xFF1E88E5)),
                        ),
                      ),
                      onChanged: (value) {
                        setDialogState(() {
                          isFormComplete = nameController.text.isNotEmpty &&
                              categoryController.text.isNotEmpty &&
                              priceController.text.isNotEmpty &&
                              stockController.text.isNotEmpty;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: priceController,
                      style: GoogleFonts.inter(color: _isDarkMode ? Colors.white : const Color(0xFF212121)),
                      decoration: InputDecoration(
                        labelText: 'Prix (FCFA) *',
                        labelStyle: GoogleFonts.inter(color: _isDarkMode ? Colors.grey[400] : const Color(0xFF757575)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: _isDarkMode ? Colors.grey[700]! : Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xFF1E88E5)),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setDialogState(() {
                          isFormComplete = nameController.text.isNotEmpty &&
                              categoryController.text.isNotEmpty &&
                              priceController.text.isNotEmpty &&
                              stockController.text.isNotEmpty;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: stockController,
                      style: GoogleFonts.inter(color: _isDarkMode ? Colors.white : const Color(0xFF212121)),
                      decoration: InputDecoration(
                        labelText: 'Stock (unités) *',
                        labelStyle: GoogleFonts.inter(color: _isDarkMode ? Colors.grey[400] : const Color(0xFF757575)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: _isDarkMode ? Colors.grey[700]! : Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xFF1E88E5)),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setDialogState(() {
                          isFormComplete = nameController.text.isNotEmpty &&
                              categoryController.text.isNotEmpty &&
                              priceController.text.isNotEmpty &&
                              stockController.text.isNotEmpty;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: isFormComplete ? 1.0 : 0.5,
                      backgroundColor: _isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF1E88E5)),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Annuler',
                    style: GoogleFonts.inter(
                      color: _isDarkMode ? Colors.grey[400] : const Color(0xFF757575),
                      fontSize: 14,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: isFormComplete
                      ? () {
                          setState(() {
                            products[index] = Product(
                              name: nameController.text,
                              category: categoryController.text,
                              price: '${priceController.text} FCFA',
                              stock: '${stockController.text} unités',
                              status: product.status,
                            );
                          });
                          Navigator.of(context).pop();
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E88E5),
                    disabledBackgroundColor: _isDarkMode ? Colors.grey[700]! : Colors.grey[400]!,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    minimumSize: const Size(44, 44),
                  ),
                  child: Text(
                    'Modifier',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _deleteProduct(int index) {
    setState(() {
      products.removeAt(index);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Modular.to.navigate('/dashboard/');
        break;
      case 1:
        Modular.to.navigate('/dashboard/products/');
        break;
      case 2:
        Modular.to.navigate('/dashboard/orders/');
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
    isSmallScreen = width < 400;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: _isDarkMode ? const Color(0xFF121212) : const Color(0xFFFFFFFF),
      drawer: isMobile ? _buildDrawer() : null,
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
                          _buildWelcomeCard(),
                          const SizedBox(height: 8),
                          _buildKpiCards(),
                          const SizedBox(height: 8),
                          _buildRecentProducts(),
                          const SizedBox(height: 8),
                          _buildRecentOrders(),
                          const SizedBox(height: 8),
                          _buildRecentNegotiations(),
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
      floatingActionButton: isMobile ? null : FloatingActionButton(
        onPressed: _showAddProductDialog,
        backgroundColor: const Color(0xFF1E88E5),
        child: const Icon(Icons.add, color: Colors.white, size: 20),
        tooltip: 'Ajouter un produit',
        mini: isMobile,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: isMobile
          ? AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: _isNavBarVisible ? 70.0 : 0.0,
              child: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.home, size: 24),
                    activeIcon: const Icon(Icons.home, size: 28, color: Color(0xFF1E88E5)),
                    label: 'Accueil',
                    tooltip: 'Tableau de bord',
                    backgroundColor: _isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.inventory_2, size: 24),
                    activeIcon: const Icon(Icons.inventory_2, size: 28, color: Color(0xFF1E88E5)),
                    label: 'Produits',
                    tooltip: 'Mes produits',
                    backgroundColor: _isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.shopping_cart, size: 24),
                    activeIcon: const Icon(Icons.shopping_cart, size: 28, color: Color(0xFF1E88E5)),
                    label: 'Commandes',
                    tooltip: 'Commandes',
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
                                color: Color(0xFFE53935),
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '$_unreadNotifications',
                                style: GoogleFonts.inter(
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
                        const Icon(Icons.notifications, size: 28, color: Color(0xFF1E88E5)),
                        if (_unreadNotifications > 0)
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: Color(0xFFE53935),
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '$_unreadNotifications',
                                style: GoogleFonts.inter(
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
                    activeIcon: const Icon(Icons.person, size: 28, color: Color(0xFF1E88E5)),
                    label: 'Profil',
                    tooltip: 'Paramètres',
                    backgroundColor: _isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: const Color(0xFF1E88E5),
                unselectedItemColor: _isDarkMode ? Colors.grey[400] : const Color(0xFF757575),
                selectedLabelStyle: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: GoogleFonts.inter(
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

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: _isDarkMode ? const Color(0xFF1E1E1E) : const Color(0xFFFFFFFF),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF1E88E5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/gthint.png',
                  height: 32,
                ),
                const SizedBox(height: 8),
                Text(
                  'GlobalTrade Hub',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          _buildSidebarItem(
            icon: Icons.dashboard_outlined,
            title: 'Tableau de bord',
            onTap: () {
              Modular.to.navigate('/dashboard/');
              _scaffoldKey.currentState?.closeDrawer();
            },
            isExpanded: true,
          ),
          _buildSidebarItem(
            icon: Icons.inventory_2_outlined,
            title: 'Mes produits',
            onTap: () {
              Modular.to.navigate('/dashboard/products/');
              _scaffoldKey.currentState?.closeDrawer();
            },
            isExpanded: true,
          ),
          _buildSidebarItem(
            icon: Icons.shopping_cart_outlined,
            title: 'Commandes',
            onTap: () {
              Modular.to.navigate('/dashboard/orders/');
              _scaffoldKey.currentState?.closeDrawer();
            },
            isExpanded: true,
          ),
          _buildSidebarItem(
            icon: Icons.handshake_outlined,
            title: 'Négociations',
            onTap: () {
              Modular.to.navigate('/dashboard/negotiations/');
              _scaffoldKey.currentState?.closeDrawer();
            },
            isExpanded: true,
          ),
          _buildSidebarItem(
            icon: Icons.storefront_outlined,
            title: 'Catalogue & Stock',
            onTap: () {
              Modular.to.navigate('/dashboard/stock/');
              _scaffoldKey.currentState?.closeDrawer();
            },
            isExpanded: true,
          ),
          _buildSidebarItem(
            icon: Icons.report_problem_outlined,
            title: 'Réclamations',
            onTap: () {
              Modular.to.navigate('/dashboard/complaints/');
              _scaffoldKey.currentState?.closeDrawer();
            },
            isExpanded: true,
          ),
          _buildSidebarItem(
            icon: Icons.local_shipping_outlined,
            title: 'Logistique',
            onTap: () {
              Modular.to.navigate('/logistique/');
              _scaffoldKey.currentState?.closeDrawer();
            },
            isExpanded: true,
          ),
          _buildSidebarItem(
            icon: Icons.description_outlined,
            title: 'Documents légaux',
            onTap: () {
              Modular.to.navigate('/dashboard/documents/');
              _scaffoldKey.currentState?.closeDrawer();
            },
            isExpanded: true,
          ),
          _buildSidebarItem(
            icon: Icons.bar_chart_outlined,
            title: 'Statistiques',
            onTap: () {
              Modular.to.navigate('/dashboard/stats/');
              _scaffoldKey.currentState?.closeDrawer();
            },
            isExpanded: true,
          ),
          _buildSidebarItem(
            icon: Icons.star_border_outlined,
            title: 'Abonnement Premium',
            onTap: () {
              Modular.to.navigate('/dashboard/premium/');
              _scaffoldKey.currentState?.closeDrawer();
            },
            isExpanded: true,
          ),
          _buildSidebarItem(
            icon: Icons.message_outlined,
            title: 'Messagerie',
            onTap: () {
              Modular.to.navigate('/dashboard/messaging/');
              _scaffoldKey.currentState?.closeDrawer();
            },
            isExpanded: true,
          ),
          _buildSidebarItem(
            icon: Icons.favorite_border,
            title: 'Favoris acheteurs',
            onTap: () {
              Modular.to.navigate('/dashboard/favorites/');
              _scaffoldKey.currentState?.closeDrawer();
            },
            isExpanded: true,
          ),
          _buildSidebarItem(
            icon: Icons.security_outlined,
            title: 'Blockchain Trace',
            onTap: () {
              Modular.to.navigate('/dashboard/blockchain/');
              _scaffoldKey.currentState?.closeDrawer();
            },
            isExpanded: true,
          ),
          _buildSidebarItem(
            icon: Icons.support_agent_outlined,
            title: 'Support & Aide',
            onTap: () {
              Modular.to.navigate('/dashboard/support/');
              _scaffoldKey.currentState?.closeDrawer();
            },
            isExpanded: true,
          ),
          _buildSidebarItem(
            icon: Icons.settings_outlined,
            title: 'Paramètres',
            onTap: () {
              Modular.to.navigate('/dashboard/profile/');
              _scaffoldKey.currentState?.closeDrawer();
            },
            isExpanded: true,
          ),
        ],
      ),
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
              color: _isDarkMode ? Colors.white : const Color(0xFF212121),
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
                  icon: Icons.dashboard_outlined,
                  title: 'Tableau de bord',
                  onTap: () {
                    Modular.to.navigate('/dashboard/');
                  },
                  isExpanded: _isSidebarExpanded,
                ),
                _buildSidebarItem(
                  icon: Icons.inventory_2_outlined,
                  title: 'Mes produits',
                  onTap: () {
                    Modular.to.navigate('/dashboard/products/');
                  },
                  isExpanded: _isSidebarExpanded,
                ),
                _buildSidebarItem(
                  icon: Icons.shopping_cart_outlined,
                  title: 'Commandes',
                  onTap: () {
                    Modular.to.navigate('/dashboard/orders/');
                  },
                  isExpanded: _isSidebarExpanded,
                ),
                _buildSidebarItem(
                  icon: Icons.handshake_outlined,
                  title: 'Négociations',
                  onTap: () {
                    Modular.to.navigate('/dashboard/negotiations/');
                  },
                  isExpanded: _isSidebarExpanded,
                ),
                _buildSidebarItem(
                  icon: Icons.storefront_outlined,
                  title: 'Catalogue & Stock',
                  onTap: () {
                    Modular.to.navigate('/dashboard/stock/');
                  },
                  isExpanded: _isSidebarExpanded,
                ),
                _buildSidebarItem(
                  icon: Icons.report_problem_outlined,
                  title: 'Réclamations',
                  onTap: () {
                    Modular.to.navigate('/dashboard/complaints/');
                  },
                  isExpanded: _isSidebarExpanded,
                ),
                _buildSidebarItem(
                  icon: Icons.local_shipping_outlined,
                  title: 'Logistique',
                  onTap: () {
                    Modular.to.navigate('/logistique/');
                  },
                  isExpanded: _isSidebarExpanded,
                ),
                _buildSidebarItem(
                  icon: Icons.description_outlined,
                  title: 'Documents légaux',
                  onTap: () {
                    Modular.to.navigate('/dashboard/documents/');
                  },
                  isExpanded: _isSidebarExpanded,
                ),
                _buildSidebarItem(
                  icon: Icons.bar_chart_outlined,
                  title: 'Statistiques',
                  onTap: () {
                    Modular.to.navigate('/dashboard/stats/');
                  },
                  isExpanded: _isSidebarExpanded,
                ),
                _buildSidebarItem(
                  icon: Icons.star_border_outlined,
                  title: 'Abonnement Premium',
                  onTap: () {
                    Modular.to.navigate('/dashboard/premium/');
                  },
                  isExpanded: _isSidebarExpanded,
                ),
                _buildSidebarItem(
                  icon: Icons.message_outlined,
                  title: 'Messagerie',
                  onTap: () {
                    Modular.to.navigate('/dashboard/messaging/');
                  },
                  isExpanded: _isSidebarExpanded,
                ),
                _buildSidebarItem(
                  icon: Icons.favorite_border,
                  title: 'Favoris acheteurs',
                  onTap: () {
                    Modular.to.navigate('/dashboard/favorites/');
                  },
                  isExpanded: _isSidebarExpanded,
                ),
                _buildSidebarItem(
                  icon: Icons.security_outlined,
                  title: 'Blockchain Trace',
                  onTap: () {
                    Modular.to.navigate('/dashboard/blockchain/');
                  },
                  isExpanded: _isSidebarExpanded,
                ),
                _buildSidebarItem(
                  icon: Icons.support_agent_outlined,
                  title: 'Support & Aide',
                  onTap: () {
                    Modular.to.navigate('/dashboard/support/');
                  },
                  isExpanded: _isSidebarExpanded,
                ),
                _buildSidebarItem(
                  icon: Icons.settings_outlined,
                  title: 'Paramètres',
                  onTap: () {
                    Modular.to.navigate('/dashboard/profile/');
                  },
                  isExpanded: _isSidebarExpanded,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required bool isExpanded,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: const Color(0xFF1E88E5),
        size: 20,
      ),
      title: isExpanded
          ? Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: _isDarkMode ? Colors.white : const Color(0xFF212121),
              ),
            )
          : null,
      onTap: onTap,
      hoverColor: _isDarkMode ? Colors.white.withOpacity(0.1) : Colors.grey[100],
      tileColor: Colors.transparent,
      minLeadingWidth: 20,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
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
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
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
              height: isSmallScreen ? 24 : 32,
            ),
          ),
          const SizedBox(width: 8),
          if (isDesktop)
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: _isDarkMode ? const Color(0xFF2D2D2D) : const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _searchController,
                  style: GoogleFonts.inter(
                    color: _isDarkMode ? Colors.white : const Color(0xFF212121),
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Rechercher...',
                    hintStyle: GoogleFonts.inter(
                      color: _isDarkMode ? Colors.grey[400] : const Color(0xFF757575),
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFF1E88E5),
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
              color: _isDarkMode ? Colors.white : const Color(0xFF212121),
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
                  color: Color(0xFF1E88E5),
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
                      color: Color(0xFFE53935),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$_unreadNotifications',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
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
                  'Mon compte',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: _isDarkMode ? Colors.white : const Color(0xFF212121),
                  ),
                ),
              ),
              PopupMenuItem(
                value: 'settings',
                child: Text(
                  'Paramètres',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: _isDarkMode ? Colors.white : const Color(0xFF212121),
                  ),
                ),
              ),
              PopupMenuItem(
                value: 'logout',
                child: Text(
                  'Déconnexion',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: _isDarkMode ? Colors.white : const Color(0xFF212121),
                  ),
                ),
              ),
            ],
            child: const CircleAvatar(
              radius: 16,
              backgroundColor: Color(0xFF1E88E5),
              child: Icon(Icons.person, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Container(
      padding: const EdgeInsets.all(8),
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
      child: Row(
        children: [
          const CircleAvatar(
            radius: 16,
            backgroundColor: Color(0xFF1E88E5),
            child: Icon(Icons.store, color: Colors.white, size: 16),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bienvenue, Fournisseur !',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: _isDarkMode ? Colors.white : const Color(0xFF212121),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  'Gérez vos produits.',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: _isDarkMode ? Colors.grey[400] : const Color(0xFF757575),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKpiCards() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Aperçu des performances',
          style: GoogleFonts.inter(
            fontSize: isSmallScreen ? 18 : 20,
            fontWeight: FontWeight.w600,
            color: _isDarkMode ? Colors.white : const Color(0xFF212121),
          ),
        ),
        const SizedBox(height: 8),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(), // Fixed syntax
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: isSmallScreen ? 320 : isMobile ? 300 : 250,
            childAspectRatio: isMobile ? 3 : 1.5,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: 8,
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                return _buildKpiCard(
                  title: 'Produits actifs',
                  value: '45',
                  subTitle: '10 en attente',
                  icon: Icons.inventory_2_outlined,
                );
              case 1:
                return _buildKpiCard(
                  title: 'Stock disponible',
                  value: '1200 unités',
                  subTitle: '3 produits bas',
                  icon: Icons.storefront_outlined,
                );
              case 2:
                return _buildKpiCard(
                  title: 'Commandes en attente',
                  value: '8',
                  subTitle: '2 urgentes',
                  icon: Icons.shopping_cart_outlined,
                );
              case 3:
                return _buildKpiCard(
                  title: 'Ventes réalisées',
                  value: '150',
                  subTitle: '5M FCFA',
                  icon: Icons.check_circle_outline,
                );
              case 4:
                return _buildKpiCard(
                  title: 'Revenus ce mois',
                  value: '2M FCFA',
                  subTitle: '+15% vs mois dernier',
                  icon: Icons.monetization_on_outlined,
                );
              case 5:
                return _buildKpiCard(
                  title: 'Délai moyen livraison',
                  value: '3 jours',
                  subTitle: 'Stable',
                  icon: Icons.local_shipping_outlined,
                );
              case 6:
                return _buildKpiCard(
                  title: 'Négociations ouvertes',
                  value: '5',
                  subTitle: '3 en attente',
                  icon: Icons.handshake_outlined,
                );
              case 7:
                return _buildKpiCard(
                  title: 'Réclamations en cours',
                  value: '2',
                  subTitle: '1 urgente',
                  icon: Icons.report_problem_outlined,
                );
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }

  Widget _buildKpiCard({
    required String title,
    required String value,
    required String subTitle,
    required IconData icon,
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 14,
                  backgroundColor: Color(0xFF1E88E5),
                  child: Icon(Icons.inventory_2, color: Colors.white, size: 14),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: _isDarkMode ? Colors.grey[400] : const Color(0xFF757575),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        value,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _isDarkMode ? Colors.white : const Color(0xFF212121),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (!isMobile)
                        const SizedBox(height: 2),
                      if (!isMobile)
                        Text(
                          subTitle,
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            color: _isDarkMode ? Colors.grey[400] : const Color(0xFF757575),
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

  Widget _buildRecentProducts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mes produits récents',
          style: GoogleFonts.inter(
            fontSize: isSmallScreen ? 18 : 20,
            fontWeight: FontWeight.w600,
            color: _isDarkMode ? Colors.white : const Color(0xFF212121),
          ),
        ),
        const SizedBox(height: 8),
        ...products.asMap().entries.map((entry) {
          int index = entry.key;
          Product product = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _buildProductItem(
              index: index,
              name: product.name,
              category: product.category,
              price: product.price,
              stock: product.stock,
              status: product.status,
            ),
          );
        }),
      ],
    );
  }

  Widget _buildProductItem({
    required int index,
    required String name,
    required String category,
    required String price,
    required String stock,
    required String status,
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        leading: const CircleAvatar(
          radius: 14,
          backgroundColor: Color(0xFF1E88E5),
          child: Icon(Icons.inventory_2, color: Colors.white, size: 14),
        ),
        title: Text(
          name,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: _isDarkMode ? Colors.white : const Color(0xFF212121),
          ),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          price,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: _isDarkMode ? Colors.grey[400] : const Color(0xFF757575),
          ),
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              status,
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: status == 'Actif' ? const Color(0xFF4CAF50) : const Color(0xFFE53935),
              ),
            ),
            const SizedBox(width: 4),
            GestureDetector(
              onTap: () {
                _showEditProductDialog(index);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.edit,
                  color: Color(0xFF1E88E5),
                  size: 16,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _deleteProduct(index);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.delete,
                  color: Color(0xFFE53935),
                  size: 16,
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          Modular.to.navigate('/dashboard/products/');
        },
      ),
    );
  }

  Widget _buildRecentOrders() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Commandes récentes',
          style: GoogleFonts.inter(
            fontSize: isSmallScreen ? 18 : 20,
            fontWeight: FontWeight.w600,
            color: _isDarkMode ? Colors.white : const Color(0xFF212121),
          ),
        ),
        const SizedBox(height: 8),
        _buildOrderItem(
          buyer: 'Acheteur A',
          product: 'Biscuits 500g',
          quantity: '100',
          amount: '500 000 FCFA',
          status: 'En cours',
        ),
        const SizedBox(height: 8),
        _buildOrderItem(
          buyer: 'Acheteur B',
          product: 'Meubles de bureau',
          quantity: '5',
          amount: '750 000 FCFA',
          status: 'Payé',
        ),
      ],
    );
  }

  Widget _buildOrderItem({
    required String buyer,
    required String product,
    required String quantity,
    required String amount,
    required String status,
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        leading: const CircleAvatar(
          radius: 14,
          backgroundColor: Color(0xFF1E88E5),
          child: Icon(Icons.shopping_cart, color: Colors.white, size: 14),
        ),
        title: Text(
          buyer,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: _isDarkMode ? Colors.white : const Color(0xFF212121),
          ),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          amount,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: _isDarkMode ? Colors.grey[400] : const Color(0xFF757575),
          ),
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          status,
          style: GoogleFonts.inter(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: status == 'Payé' ? const Color(0xFF4CAF50) : const Color(0xFFE53935),
          ),
        ),
        onTap: () {
          Modular.to.navigate('/dashboard/orders/');
        },
      ),
    );
  }

  Widget _buildRecentNegotiations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Négociations récentes',
          style: GoogleFonts.inter(
            fontSize: isSmallScreen ? 18 : 20,
            fontWeight: FontWeight.w600,
            color: _isDarkMode ? Colors.white : const Color(0xFF212121),
          ),
        ),
        const SizedBox(height: 8),
        _buildNegotiationItem(
          buyer: 'Acheteur A',
          product: 'Biscuits 500g',
          amount: '500 000 FCFA',
          status: 'En cours',
          progress: 0.7,
        ),
        const SizedBox(height: 8),
        _buildNegotiationItem(
          buyer: 'Acheteur B',
          product: 'Meubles de bureau',
          amount: '750 000 FCFA',
          status: 'Proposition envoyée',
          progress: 0.4,
        ),
      ],
    );
  }

  Widget _buildNegotiationItem({
    required String buyer,
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        leading: CircularPercentIndicator(
          radius: 14,
          lineWidth: 3,
          percent: progress,
          center: Text(
            '${(progress * 100).toInt()}%',
            style: GoogleFonts.inter(
              fontSize: 10,
              color: _isDarkMode ? Colors.white : const Color(0xFF212121),
            ),
          ),
          progressColor: const Color(0xFF1E88E5),
          backgroundColor: _isDarkMode ? Colors.grey[700]! : Colors.grey[200]!,
        ),
        title: Text(
          buyer,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: _isDarkMode ? Colors.white : const Color(0xFF212121),
          ),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          amount,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: _isDarkMode ? Colors.grey[400] : const Color(0xFF757575),
          ),
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          status,
          style: GoogleFonts.inter(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: status == 'En cours' ? const Color(0xFFE53935) : const Color(0xFF4CAF50),
          ),
        ),
        onTap: () {
          Modular.to.navigate('/dashboard/negotiations/');
        },
      ),
    );
  }
}