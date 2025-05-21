import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// Modèles simplifiés
class ProviderModel {
  final String id;
  final String name;
  final String status;
  final DateTime joinDate;
  final double rating;

  ProviderModel({required this.id, required this.name, required this.status, required this.joinDate, required this.rating});
}

class UserModel {
  final String id;
  final String name;
  final String phone;
  final String status;
  final DateTime lastLogin;

  UserModel({required this.id, required this.name, required this.phone, required this.status, required this.lastLogin});
}

class AdminState with ChangeNotifier {
  List<ProviderModel> providers = [];
  List<UserModel> users = [];
  int activeProviders = 0;
  int transactions24h = 0;
  int openDisputes = 0;
  int newUsers = 0;

  void loadData() {
    // Simulation de données (à remplacer par une API)
    providers = List.generate(1000, (index) => ProviderModel(
      id: 'P$index',
      name: 'Fournisseur $index',
      status: index % 3 == 0 ? 'Vérifié' : index % 3 == 1 ? 'En attente' : 'Suspendu',
      joinDate: DateTime.now().subtract(Duration(days: index)),
      rating: 3.0 + (index % 3),
    ));
    users = List.generate(10000, (index) => UserModel(
      id: 'U$index',
      name: 'Utilisateur $index',
      phone: '+229 12345678$index',
      status: index % 2 == 0 ? 'Actif' : 'Bloqué',
      lastLogin: DateTime.now().subtract(Duration(days: index % 30)),
    ));
    activeProviders = providers.where((p) => p.status == 'Vérifié').length;
    transactions24h = 120;
    openDisputes = 5;
    newUsers = 15;
    notifyListeners();
  }
}

class DashboardAdminView extends StatefulWidget {
  const DashboardAdminView({super.key});

  @override
  State<DashboardAdminView> createState() => _DashboardAdminViewState();
}

class _DashboardAdminViewState extends State<DashboardAdminView> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late bool isMobile;
  late bool isDesktop;
  int _selectedIndex = 0;
  final PageController _kpiController = PageController();
  final TextEditingController _searchController = TextEditingController();
  int _currentPage = 1;
  final int _itemsPerPage = 10;

  @override
  void initState() {
    super.initState();
    Provider.of<AdminState>(context, listen: false).loadData();
  }

  @override
  void dispose() {
    _kpiController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    Modular.to.navigate([
      '/admin/',
      '/admin/providers',
      '/admin/users',
      '/admin/transactions',
      '/admin/logistics',
      '/admin/reports',
      '/admin/settings',
    ][index]);
  }

  List<ProviderModel> _filterProviders(String query) {
    final state = Provider.of<AdminState>(context, listen: false);
    return state.providers.where((p) => p.name.toLowerCase().contains(query.toLowerCase())).toList();
  }

  List<UserModel> _filterUsers(String query) {
    final state = Provider.of<AdminState>(context, listen: false);
    return state.users.where((u) => u.name.toLowerCase().contains(query.toLowerCase())).toList();
  }

  void _showActionDialog(String id, String type, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmer l\'action', style: GoogleFonts.orbitron()),
        content: Text('Voulez-vous vraiment $type $id ?', style: GoogleFonts.robotoSlab()),
        actions: [
          TextButton(child: const Text('Annuler'), onPressed: () => Navigator.pop(context)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C63FF)),
            child: const Text('Oui', style: TextStyle(color: Colors.white)),
            onPressed: () {
              onConfirm();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    isMobile = width < 600;
    isDesktop = width >= 800;
    final state = Provider.of<AdminState>(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 2,
        leading: isMobile
            ? IconButton(
                icon: const Icon(Icons.menu, color: Color(0xFF0A0F1E)),
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              )
            : null,
        title: Row(
          children: [
            Image.asset('assets/images/gthint.png', height: 32),
            const SizedBox(width: 8),
            Text('Dashboard Admin', style: GoogleFonts.orbitron(fontSize: 24, color: const Color(0xFF0A0F1E))),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.notifications, color: Color(0xFF6C63FF)), onPressed: () {}),
          IconButton(icon: const Icon(Icons.person, color: Color(0xFF6C63FF)), onPressed: () {}),
          IconButton(icon: const Icon(Icons.logout, color: Color(0xFF6C63FF)), onPressed: () => Modular.to.navigate('/auth')),
        ],
      ),
      drawer: isMobile ? _buildDrawer() : null,
      body: Row(
        children: [
          if (isDesktop) _buildSidebar(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(isMobile ? 8.0 : 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildKpiSection(state),
                    const SizedBox(height: 24),
                    _buildSearchSection(),
                    const SizedBox(height: 16),
                    _buildProvidersSection(state),
                    const SizedBox(height: 24),
                    _buildUsersSection(state),
                    const SizedBox(height: 24),
                    _buildDisputesSection(state),
                    const SizedBox(height: 24),
                    _buildAnalyticsSection(state),
                    const SizedBox(height: 24),
                    _buildActionButton(),
                    const SizedBox(height: 16),
                    _buildFooter(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: isMobile ? _buildBottomNavBar() : null,
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Container(
        color: const Color(0xFFFFFFFF),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF6C63FF)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Menu Admin', style: GoogleFonts.orbitron(fontSize: 20, color: Colors.white)),
                  IconButton(icon: const Icon(Icons.close, color: Colors.white), onPressed: () => _scaffoldKey.currentState?.closeDrawer()),
                ],
              ),
            ),
            _buildNavItem(Icons.home, 'Accueil', 0),
            _buildNavItem(Icons.store, 'Fournisseurs', 1),
            _buildNavItem(Icons.people, 'Utilisateurs', 2),
            _buildNavItem(Icons.payment, 'Transactions', 3),
            _buildNavItem(Icons.local_shipping, 'Logistique', 4),
            _buildNavItem(Icons.bar_chart, 'Rapports', 5),
            _buildNavItem(Icons.settings, 'Paramètres', 6),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 250,
      color: const Color(0xFFFFFFFF),
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          Image.asset('assets/images/gthint.png', height: 32),
          const SizedBox(height: 16),
          _buildNavItem(Icons.home, 'Accueil', 0),
          _buildNavItem(Icons.store, 'Fournisseurs', 1),
          _buildNavItem(Icons.people, 'Utilisateurs', 2),
          _buildNavItem(Icons.payment, 'Transactions', 3),
          _buildNavItem(Icons.local_shipping, 'Logistique', 4),
          _buildNavItem(Icons.bar_chart, 'Rapports', 5),
          _buildNavItem(Icons.settings, 'Paramètres', 6),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF6C63FF), size: 24),
      title: Text(title, style: GoogleFonts.robotoSlab(fontSize: 16, color: const Color(0xFF0A0F1E))),
      selected: _selectedIndex == index,
      onTap: () {
        _onItemTapped(index);
        if (isMobile) _scaffoldKey.currentState?.closeDrawer();
      },
      tileColor: _selectedIndex == index ? const Color(0xFFF5F5F5) : null,
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
        BottomNavigationBarItem(icon: Icon(Icons.payment), label: 'Transactions'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: const Color(0xFF6C63FF),
      onTap: _onItemTapped,
    );
  }

  Widget _buildKpiSection(AdminState state) {
    return Container(
      height: isMobile ? 140 : 180,
      child: PageView(
        controller: _kpiController,
        children: [
          _buildKpiCard('Fournisseurs actifs', '${state.activeProviders}', Icons.store, const Color(0xFF6C63FF)),
          _buildKpiCard('Transactions (24h)', '${state.transactions24h}', Icons.payment, const Color(0xFF00FFFF)),
          _buildKpiCard('Litiges ouverts', '${state.openDisputes}', Icons.warning, const Color(0xFFE53935)),
          _buildKpiCard('Nouveaux utilisateurs', '${state.newUsers}', Icons.person_add, const Color(0xFF6C63FF)),
        ],
      ),
    );
  }

  Widget _buildKpiCard(String title, String value, IconData icon, Color color) {
    return Hero(
      tag: title,
      child: GestureDetector(
        onTap: () {},
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black12.withOpacity(0.2), blurRadius: 8)],
            border: Border.all(color: color.withOpacity(0.6)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(backgroundColor: color, radius: 20, child: Icon(icon, color: Colors.white, size: 24)),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: GoogleFonts.robotoSlab(fontSize: isMobile ? 14 : 16, color: const Color(0xFF718096))),
                      Text(value, style: GoogleFonts.orbitron(fontSize: isMobile ? 20 : 28, color: const Color(0xFF0A0F1E))),
                    ],
                  ),
                ],
              ),
              const Icon(Icons.chevron_right, color: Color(0xFF6C63FF)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchSection() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Rechercher (nom, ID, statut)...',
              prefixIcon: const Icon(Icons.search, color: Color(0xFF6C63FF)),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
              fillColor: const Color(0xFFF5F5F5),
            ),
            onChanged: (value) => setState(() {}),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C63FF)),
          onPressed: () {},
          child: const Text('Filtres', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Widget _buildProvidersSection(AdminState state) {
    final filteredProviders = _filterProviders(_searchController.text);
    final start = (_currentPage - 1) * _itemsPerPage;
    final end = start + _itemsPerPage;
    final paginatedProviders = filteredProviders.sublist(start, end > filteredProviders.length ? filteredProviders.length : end);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Fournisseurs', style: GoogleFonts.orbitron(fontSize: isMobile ? 20 : 28, color: const Color(0xFF0A0F1E))),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: paginatedProviders.length,
          itemBuilder: (context, index) => _buildProviderCard(paginatedProviders[index]),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFF6C63FF)),
              onPressed: _currentPage > 1 ? () => setState(() => _currentPage--) : null,
            ),
            Text('Page $_currentPage', style: GoogleFonts.robotoSlab(fontSize: 16)),
            IconButton(
              icon: const Icon(Icons.arrow_forward, color: Color(0xFF6C63FF)),
              onPressed: end < filteredProviders.length ? () => setState(() => _currentPage++) : null,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProviderCard(ProviderModel provider) {
    return Hero(
      tag: 'provider_${provider.id}',
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black12.withOpacity(0.2), blurRadius: 8)],
        ),
        child: Row(
          children: [
            CircleAvatar(backgroundColor: const Color(0xFF6C63FF), radius: 24, child: Text(provider.id[1], style: const TextStyle(color: Colors.white))),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(provider.name, style: GoogleFonts.robotoSlab(fontSize: 16, color: const Color(0xFF0A0F1E))),
                  Text('Statut: ${provider.status}', style: GoogleFonts.robotoSlab(fontSize: 14, color: provider.status == 'Vérifié' ? Colors.green : Colors.red)),
                  Text('Inscription: ${provider.joinDate.toLocal().toString().split(' ')[0]}', style: GoogleFonts.robotoSlab(fontSize: 14, color: const Color(0xFF718096))),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.check_circle, color: Color(0xFF6C63FF)),
                  onPressed: () => _showActionDialog(provider.id, 'valider', () {}),
                ),
                IconButton(
                  icon: const Icon(Icons.block, color: Color(0xFFE53935)),
                  onPressed: () => _showActionDialog(provider.id, 'suspendre', () {}),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUsersSection(AdminState state) {
    final filteredUsers = _filterUsers(_searchController.text);
    final start = (_currentPage - 1) * _itemsPerPage;
    final end = start + _itemsPerPage;
    final paginatedUsers = filteredUsers.sublist(start, end > filteredUsers.length ? filteredUsers.length : end);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Utilisateurs', style: GoogleFonts.orbitron(fontSize: isMobile ? 20 : 28, color: const Color(0xFF0A0F1E))),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: paginatedUsers.length,
          itemBuilder: (context, index) => _buildUserCard(paginatedUsers[index]),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFF6C63FF)),
              onPressed: _currentPage > 1 ? () => setState(() => _currentPage--) : null,
            ),
            Text('Page $_currentPage', style: GoogleFonts.robotoSlab(fontSize: 16)),
            IconButton(
              icon: const Icon(Icons.arrow_forward, color: Color(0xFF6C63FF)),
              onPressed: end < filteredUsers.length ? () => setState(() => _currentPage++) : null,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUserCard(UserModel user) {
    return Hero(
      tag: 'user_${user.id}',
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black12.withOpacity(0.2), blurRadius: 8)],
        ),
        child: Row(
          children: [
            CircleAvatar(backgroundColor: const Color(0xFF6C63FF), radius: 24, child: Text(user.id[1], style: const TextStyle(color: Colors.white))),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.name, style: GoogleFonts.robotoSlab(fontSize: 16, color: const Color(0xFF0A0F1E))),
                  Text('Tel: ${user.phone}', style: GoogleFonts.robotoSlab(fontSize: 14, color: const Color(0xFF718096))),
                  Text('Statut: ${user.status}', style: GoogleFonts.robotoSlab(fontSize: 14, color: user.status == 'Actif' ? Colors.green : Colors.red)),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.check_circle, color: Color(0xFF6C63FF)),
                  onPressed: () => _showActionDialog(user.id, 'activer', () {}),
                ),
                IconButton(
                  icon: const Icon(Icons.block, color: Color(0xFFE53935)),
                  onPressed: () => _showActionDialog(user.id, 'bloquer', () {}),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDisputesSection(AdminState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Litiges en cours', style: GoogleFonts.orbitron(fontSize: isMobile ? 20 : 28, color: const Color(0xFF0A0F1E))),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.openDisputes,
          itemBuilder: (context, index) => _buildDisputeCard(index),
        ),
      ],
    );
  }

  Widget _buildDisputeCard(int index) {
    return Hero(
      tag: 'dispute_$index',
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black12.withOpacity(0.2), blurRadius: 8)],
        ),
        child: Row(
          children: [
            CircleAvatar(backgroundColor: const Color(0xFFE53935), radius: 24, child: Text('D$index', style: const TextStyle(color: Colors.white))),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Litige #$index', style: GoogleFonts.robotoSlab(fontSize: 16, color: const Color(0xFF0A0F1E))),
                  Text('Catégorie: Paiement', style: GoogleFonts.robotoSlab(fontSize: 14, color: const Color(0xFF718096))),
                  Text('Statut: En cours', style: GoogleFonts.robotoSlab(fontSize: 14, color: Colors.orange)),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C63FF)),
              onPressed: () {},
              child: Text('Résoudre', style: GoogleFonts.robotoSlab(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalyticsSection(AdminState state) {
    final List<ChartData> data = [
      ChartData(DateTime(2025, 4), 50),
      ChartData(DateTime(2025, 5), 70),
      ChartData(DateTime(2025, 6), 90),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Analyse des Performances', style: GoogleFonts.orbitron(fontSize: isMobile ? 20 : 28, color: const Color(0xFF0A0F1E))),
        const SizedBox(height: 16),
        Container(
          height: 200,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black12.withOpacity(0.2), blurRadius: 8)],
          ),
          child: SfCartesianChart(
            primaryXAxis: DateTimeAxis(),
            series: <CartesianSeries<ChartData, DateTime>>[ // Correction du type ici
              LineSeries<ChartData, DateTime>(
                dataSource: data,
                xValueMapper: (ChartData sales, _) => sales.time,
                yValueMapper: (ChartData sales, _) => sales.sales,
                pointColorMapper: (_, __) => const Color(0xFF6C63FF),
                markerSettings: const MarkerSettings(isVisible: true),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C63FF)),
          onPressed: () {},
          child: Text('Exporter PDF', style: GoogleFonts.robotoSlab(color: Colors.white)),
        ),
      ],
    );
  }

  Widget _buildActionButton() {
    return Center(
      child: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Nouvelle Action', style: GoogleFonts.orbitron()),
            content: TextField(decoration: InputDecoration(labelText: 'Description', border: OutlineInputBorder())),
            actions: [
              TextButton(child: const Text('Annuler'), onPressed: () => Navigator.pop(context)),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C63FF)),
                child: const Text('Envoyer', style: TextStyle(color: Colors.white)),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
        backgroundColor: const Color(0xFF6C63FF),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(12),
      color: const Color(0xFFF5F5F5),
      child: Center(
        child: Text('GlobalTrade Hub © 2025 | v1.0', style: GoogleFonts.robotoSlab(fontSize: 14, color: const Color(0xFF718096))),
      ),
    );
  }
}

// Modèle pour les données du graphique
class ChartData {
  final DateTime time;
  final int sales;

  ChartData(this.time, this.sales);
}